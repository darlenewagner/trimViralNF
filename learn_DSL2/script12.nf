#! /apps/x86_64/nextflow/23.10.0 nextflow

nextflow.enable.dsl=2

params.query = "${baseDir}/anonymousContigs/contig*.fasta"
params.db = "${baseDir}/blastn_db/AY184220"

db_name = file(params.db).name
db_path = file(params.db).parent

process blastN {
   
   publishDir "$PWD/blastn_output/", mode: 'copy'

   input:
     tuple val(query_id), path(query)
     path db
     
   output:
     tuple val(query_id), path("${query_id}.batch_blastn.txt")

 script:
   """
     blastn -db "${db}/${db_name}" -query "${query}" -evalue 1e-100 -outfmt "6 qseqid pident length qlen slen mismatch gapopen qstart qend sstart send evalue bitscore stitle" -out "${query_id}.batch_blastn.txt"
   """
  
}



process gatherFiles {

  publishDir "${params.intermediate}", mode: 'copy'

  input:
  tuple path(blastn), path(contigs)
  
  output:
  path "${contigs.simpleName}_annot.more.fasta", emit: annotated
  
  script:
  """
    head -1 ${contigs} | awk '{ printf "%s ", \$0}' >> ${contigs.simpleName}_annot.more.fasta
    VAR2=\$(cat ${blastn} | awk 'split(\$0,a," "){ gsub(/^[ \t]+|[ \t]+\$/, ""); print a[8] "_" a[9]}')
    echo \$VAR2 >> ${contigs.simpleName}_annot.more.fasta
    egrep "^(A|C|G|T)" ${contigs} >> ${contigs.simpleName}_annot.more.fasta
  """

} 

process performTrim {

  tag { annotated.name }
  
  publishDir "${params.annote}", mode: 'copy'
  
  input:
  path(annotated)
  
  output:
  path "${annotated.simpleName}_trimmed.fasta"
  
  script:
  """
  perl $PWD/perl/trimFasta.pl ${params.intermediate}/${annotated} >> ${annotated.simpleName}_trimmed.fasta
  """
}

workflow
  {
    
    query_ch = Channel.fromPath( params.query ).map{ file -> tuple(file.baseName, file)}
    blastResults = blastN(query_ch, db_path)
    
    blastResults.view { "BlastN Results: ${it}" }
    
    /* Default Input folders: */
    params.contigs = ["/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/anonymousContigs/contig*.fasta"]    
    params.blastOut = ["/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/blastn_output/*.batch_blastn.txt"]

    params.intermediate = "$PWD/intermediate/"

    params.annote = "$PWD/annotated/"

    file_channel_1 = Channel.fromPath(params.contigs)
                            .map { tuple( it.simpleName, it) }
  			    .groupTuple().view()
    			     
    file_channel_2 = Channel.fromPath(params.blastOut)
                            .map{ tuple( it.simpleName - ~/.batch_blastn.txt/, it )}
			    .combine( file_channel_1, by: 0 )
			    .transpose( by: 2 )
			    .map { trimmed, blastn, fasta -> tuple(blastn, fasta)}.view()
      
     performTrim( gatherFiles(file_channel_2) ) | collect | view
  
     
  
  }
