#! /apps/x86_64/nextflow/23.10.0 nextflow

nextflow.enable.dsl=2


process get_contigs{

  publishDir "$PWD/see/", mode: 'copy'

  input:
  path fasta

  output:
  path 'headers2.fasta.txt'

  script:
    def all = fasta.collect { it }.join(' ')
     """
       head -1 ${fasta} > headers2.fasta.txt
     """

}

process get_blastOut{

  publishDir "$PWD/see/", mode: 'copy'

  input:
  path blastout
  
  output:
  path 'top2.blastout.txt'
  
  script:
  def all = blastout.collect { it }.join(' ')
  """
    VAR1=\$(cat ${blastout} | awk 'split(\$0,a," "){print a[8]}')
    echo \$VAR1 > top2.blastout.txt
  """

}

workflow
  {

    params.contigs = ['/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/contigs/Noro_sample_5.fasta',
		    '/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/contigs/Noro-sample-5.fasta']
    
    file_channel_1 = Channel.from(params.contigs) | collect | view
    
    get_contigs(file_channel_1) | view
    
    params.blastOut = ['/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/blastn_output/Noro_sample_5_to_OL913976.blastn.txt',
  		    '/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/blastn_output/Noro-sample-5_to_OL913976.blastn.txt']
    
    file_channel_2 = Channel.from(params.blastOut) | collect | view
    
    get_blastOut(file_channel_2) | view
  }
