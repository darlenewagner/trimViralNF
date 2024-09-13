#! /apps/x86_64/nextflow/23.10.0 nextflow

nextflow.enable.dsl=2

process VeruccaSalt {
   
   publishDir "$PWD/see/", mode: 'copy'
   
   output:
     path 'see.txt'
   
   """
     echo 'Hello World Here. Comes Your Girl Here!' > see.txt
   """
  
}




workflow {
  VeruccaSalt()
}
