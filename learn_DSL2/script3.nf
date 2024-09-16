#! /apps/x86_64/nextflow/23.10.0 nextflow

nextflow.enable.dsl=2


process song_lyrics{

  publishDir "$PWD/see/", mode: 'copy'

  input:
  path sample

  output:
  path 'all.txt'

  script:
    def all = sample.collect { it }.join(' ')
     """
       cat ${sample} > all.txt
     """

}


workflow
  {

    params.file_list = ['/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/see/test_input.txt',
		  '/scicomp/home-pure/ydn3/trimViralNF/learn_DSL2/see/more_test_input.txt']

    file_channel = Channel.from(params.file_list) | collect | view

    song_lyrics(file_channel) | view

  }
