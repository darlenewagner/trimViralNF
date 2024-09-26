#! /apps/x86_64/nextflow/23.10.0 nextflow

nextflow.enable.dsl=2


process gatherFiles {

  publishDir "$PWD/see/", mode: 'copy'

  input:
  path fasta
  path blastout
  
  output:
  path 'top4.blastout.txt'
  
  script:
  def all = blastout.collect { it }.join(' ')
  """
    VAR1=\$(head -1 ${fasta})
    VAR2=\$(cat ${blastout} | awk 'split(\$0,a," "){ gsub(/^[ \t]+|[ \t]+\$/, ""); print a[8] "_" a[9]}')
    echo \$VAR1 > top4.blastout.txt
    echo \$VAR2 >> top4.blastout.txt
  """

}

workflow
  {

    params.contigs = ["/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/contigs/*.fasta"]
        
    params.blastOut = ["/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/blastn_output/*.to_OL913976.blastn.txt"]

    file_channel_1 = Channel.fromPath(params.contigs) | collect | view
    file_channel_2 = Channel.fromPath(params.blastOut) | collect | view
    
    gatherFiles(file_channel_1, file_channel_2) | view
  }
