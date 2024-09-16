#! /apps/x86_64/nextflow/23.10.0 nextflow

nextflow.enable.dsl=2



process VerucaSalt {
   
   publishDir "$PWD/see/", mode: 'copy'

   input:
     val song_line 
   
   output:
     path 'see_1.txt'
   
   """
     echo '$song_line' > see_1.txt
   """
  
}




workflow {

  params.input_file = "see/test_input.txt"

  song_line = Channel.fromPath(params.input_file).splitText() {it.trim()}
  
  VerucaSalt(song_line)
}
