#! /apps/x86_64/nextflow/23.10.0 nextflow

nextflow.enable.dsl=2


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
  
  publishDir "${params.intermediate}", mode: 'copy'
  
  input:
  path(annotated)
  
  output:
  stdout
  
  script:
  """
  perl $PWD/perl/trimFasta.pl ${params.intermediate}/${annotated}
  """
}

workflow
  {
  
    params.contigs = ["/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/contigs/*.fasta"]
        
    params.blastOut = ["/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/blastn_output/*.blastn.txt"]

    params.intermediate = "$PWD/intermediate/"
   
    file_channel_1 = Channel.fromPath(params.contigs)
                            .map { tuple( it.simpleName, it) }
  			    .groupTuple().view()
    			     
    file_channel_2 = Channel.fromPath(params.blastOut)
                            .map{ tuple( it.simpleName - ~/.blastn.txt/, it )}
			    .combine( file_channel_1, by: 0 )
			    .transpose( by: 2 )
			    .map { trimmed, blastn, fasta -> tuple(blastn, fasta)}.view()
      
     performTrim( gatherFiles(file_channel_2) ) | collect | view

     

  }
