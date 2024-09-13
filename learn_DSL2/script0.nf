#! /apps/x86_64/nextflow/23.10.0 nextflow

nextflow.enable.dsl=2

process VerucaSalt {
   
   publishDir "$PWD/see/", mode: 'copy'
   
   output:
     path 'see_1.txt'
   
   """
     echo 'Hello World Here. Comes Your Girl Here!' > see_1.txt
   """
  
}




workflow {
  VerucaSalt()
}
