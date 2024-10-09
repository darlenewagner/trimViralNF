### Requires nextflow version 23.10.0 or higher

### A test script to output lyrics from Veruca Salt:

`nextflow run script0.nf`

`nextflow run script1.nf --song 'It''s Holy! Everybody Knows It!'`

### Testing a simple BlastN wrapper with parameters 'db' and 'query'

`nextflow run scriptMinus1.nf --db blastn_db/OL913976 --query contigs/Noro_sample_5.fasta`

### Another test script for trimming multiple contig files by blastn coordinates:

`nextflow run script11.nf --contigs "$PWD/contigs/*.fasta" --blastOut "$PWD/blastn_output/*.blastn.txt"`
