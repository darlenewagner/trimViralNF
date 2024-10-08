#! /apps/x86_64/nextflow/23.10.0 nextflow

nextflow.enable.dsl=2


process gatherFiles {

  //tag "${Bla}: ${blastn.first()}"
  //tag "${Cont}: ${contigs.first()}"
  
  publishDir "$PWD/see/", mode: 'copy'

  input:
  // tuple val(name), path(contigs)
  tuple path(blastn), path(contigs)
  // path(contigs)
  
  output:
  path 'top8.blastout.txt'
  
  script:
  def blasted = blastn.first()
  def contiggy = contigs.first()
  """
    head -1 ${contiggy} | awk '{ printf "%s ", \$0}' >> top8.blastout.txt
    VAR2=\$(cat ${blasted} | awk 'split(\$0,a," "){ gsub(/^[ \t]+|[ \t]+\$/, ""); print a[8] "_" a[9]}')
    echo \$VAR2 >> top8.blastout.txt
  """

} 

workflow
  {

    params.contigs = ["/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/contigs/*.fasta"]
        
    params.blastOut = ["/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/blastn_output/*.blastn.txt"]

    file_channel_1 = Channel.fromPath(params.contigs)
                            .map { tuple( it.simpleName, it) }
			    .groupTuple().view()
			     
    file_channel_2 = Channel.fromPath(params.blastOut)
                            .map{ tuple( it.simpleName - ~/.blastn.txt/, it )}
			    .combine( file_channel_1, by: 0 )
			    .transpose( by: 2 )
			    .map { trimmed, blastn, fasta -> tuple(blastn, fasta)}.view()
      
     gatherFiles(file_channel_2) | view
  }
