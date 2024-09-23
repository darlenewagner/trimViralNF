#! /apps/x86_64/nextflow/23.10.0 nextflow

nextflow.enable.dsl=2


process get_contigs{

  publishDir "$PWD/see/", mode: 'copy'

  input:
  path fasta

  output:
  path 'headers.txt'

  script:
    def all = fasta.collect { it }.join(' ')
     """
       head -1 ${fasta} > headers.txt
     """

}

process get_blastOut{

  publishDir "$PWD/see/", mode: 'copy'

  input:
  path fastq
  
  output:
  path 'top.txt'
  
  script:
  def all = fastq.collect { it }.join(' ')
  """
    head -1 ${fastq} > top.txt
  """

}

workflow
  {

    params.contigs = ['/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/contigs/Noro_sample_5.fasta',
		    '/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/contigs/Noro-sample-5.fasta']
    
    file_channel_1 = Channel.from(params.contigs) | collect | view
    
    get_contigs(file_channel_1) | view
    
    params.blastOut = ['/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/fastq/Noro_sample_5_S13_trimmomatic_R1.fastq',
  		    '/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/fastq/Noro_sample_5_S13_trimmomatic_R2.fastq']
    
    file_channel_2 = Channel.from(params.blastOut) | collect | view
    
    get_blastOut(file_channel_2) | view
  }
