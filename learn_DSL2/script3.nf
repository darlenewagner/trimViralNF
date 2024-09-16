#! /apps/x86_64/nextflow/23.10.0 nextflow

nextflow.enable.dsl=2




workflow {

   params.input_file = "see/test_input.txt"
   
   Channel.fromPath(params.input_file).splitText().set{ value_list }
   
  process test_song {
   input:
   path(i) from value_list

   """
   cat $i
   """

  }

}
