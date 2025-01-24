#! /apps/x86_64/nextflow/23.10.0 nextflow

nextflow.enable.dsl=2

// Assume each contig*.fasta has only one fasta-formatted nucleotide sequence

params.query = "${baseDir}/anonymousContigs/contig*.fasta"    
params.db = "${baseDir}/blastn_db/poliovirus/MZ245455"

db_name = file(params.db).name
db_path = file(params.db).parent

process blastN {
   
   container "https://depot.galaxyproject.org/singularity/blast:2.14.1--pl5321h6f7f691_0"
   
   publishDir "${baseDir}/blastn_output/", mode: 'copy'

   input:
     tuple val(query_id), path(query)
     path db
     
   output:
     tuple val(query_id), path("${query_id}.batch_blastn.txt")

 script:
   """
     blastn -db "${db}/${db_name}" -query "${query}" -evalue 1e-90 -gapopen 2 -gapextend 2 -reward 2 -penalty -3 -outfmt "6 qseqid pident length qlen slen mismatch gapopen qstart qend sstart send evalue bitscore stitle" | sort -nk8 > "${query_id}.batch_blastn.txt"
   """
  
}

process blastDB {
   
   container "https://depot.galaxyproject.org/singularity/blast:2.14.1--pl5321h6f7f691_0"
   
   publishDir "${baseDir}/blastn_db/poliovirus/", mode: 'copy'
   
   input:
   path db

   output:
   stdout
   //tuple val(db), path("${db}.n*")

   script:
   """
     echo "Imported blast2.14.1"
     makeblastdb -dbtype nucl -in "${db}/${db_name}.1.fasta" -out "${db}/${db_name}"
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
    VAR2=\$(head -1 ${blastn} | awk 'split(\$0,a," "){ gsub(/^[ \t]+|[ \t]+\$/, ""); print a[8] "_"}')
    VAR3=\$(tail -1 ${blastn} | awk 'split(\$0,b," "){ gsub(/^[ \t]+|[ \t]+\$/, ""); print b[9]}')
    echo -n \$VAR2 >> ${contigs.simpleName}_annot.more.fasta
    echo \$VAR3 >> ${contigs.simpleName}_annot.more.fasta
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
  perl ${baseDir}/perl/trimFasta.pl ${params.intermediate}/${annotated} >> ${annotated.simpleName}_trimmed.fasta
  """
}

process cullEmpty {

  publishDir "${baseDir}/annotated/", mode: 'move'

  input:
  path(trimmed)

  output:
  stdout
  

  script:
  """
  fileLength=\$(wc -l "${trimmed}" | cut -d\" \" -f1)
  if [[ \$fileLength -lt 3 ]]; then
     mv -v "${baseDir}/annotated/${trimmed}" "${baseDir}/annotated/stub.txt"
   fi  
  """
  
}



workflow
  {
   
  //   blastDB(db_path) | view
  
    
    query_ch = Channel.fromPath( params.query ).map{ file -> tuple(file.baseName, file)}
    blastResults = blastN(query_ch, db_path)
    
    blastResults.view { "BlastN Results: ${it}" }
    
    /* Default Intermediate Folders: */
    params.blastOut = ["/scicomp/home-pure/ydn3/trimViralNF/blastn_output/*.batch_blastn.txt"]
    params.intermediate = "${baseDir}/intermediate/"
    params.annote = "${baseDir}/annotated/"

    /* File Channels */
    file_channel_1 = Channel.fromPath(params.query)
                            .map { tuple( it.simpleName, it) }
  			    .groupTuple().view()
    			     
   file_channel_2 = Channel.fromPath(params.blastOut)
                            .map{ tuple( it.simpleName - ~/.batch_blastn.txt/, it )}
			    .combine( file_channel_1, by: 0 )
			    .transpose( by: 2 )
			    .map { trimmed, blastn, fasta -> tuple(blastn, fasta)}.view()
      
     file_channel_fin = performTrim( gatherFiles(file_channel_2) ) | view

     cullEmpty(file_channel_fin) | view
  
  }
