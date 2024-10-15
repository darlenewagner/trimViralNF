#! /apps/x86_64/nextflow/23.10.0 nextflow

nextflow.enable.dsl=2

params.query = "${baseDir}/polio_contigs/polio_sample_10.fasta"
params.db = "${baseDir}/blastn_db/AY184220"

db_name = file(params.db).name
db_path = file(params.db).parent

process blastN {
   
   publishDir "$PWD/blastn_output/", mode: 'copy'

   input:
     tuple val(query_id), path(query)
     path db
     
   output:
     tuple val(query_id), path("${query_id}.blastn.txt")

 script:
   """
     blastn -db "${db}/${db_name}" -query "${query}" -evalue 1e-100 -outfmt "6 qseqid pident length qlen slen mismatch gapopen qstart qend sstart send evalue bitscore stitle" -out "${query_id}.blastn.txt"
   """
  
}




workflow {

   query_ch = Channel.fromPath( params.query ).map{ file -> tuple(file.baseName, file)}
   
   blastN(query_ch, db_path) | view
}
