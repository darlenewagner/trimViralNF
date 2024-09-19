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

process get_fastq{

  publishDir "$PWD/see/", mode: 'copy'

  input:
  path fastq
  
  output:
  path 'top.txt'
  
  script:
  def all = fastq.collect { it }.join(' ')
  """
    head -4 ${fastq} > top.txt
  """

}

workflow
  {

    params.file_list1 = ['/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/contigs/Noro_sample_5.fasta',
		    '/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/contigs/Noro-sample-5.fasta']
    
    file_channel_1 = Channel.from(params.file_list1) | collect | view
    
    get_contigs(file_channel_1) | view
    
    params.file_list2 = ['/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/fastq/Noro_sample_5_S13_trimmomatic_R1.fastq',
  		    '/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/fastq/Noro_sample_5_S13_trimmomatic_R2.fastq']
    
    file_channel_2 = Channel.from(params.file_list2) | collect | view
    
    get_fastq(file_channel_2) | view
  }
