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

  params.song = "Hello World Here! Comes Your Girl Here!"

  song_line = Channel.of(params.song)
  
  VerucaSalt(song_line)
}
