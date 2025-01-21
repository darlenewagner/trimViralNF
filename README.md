### Requires nextflow version 23.10.0 or higher

#### Example:
` nextflow run trimViralContigs.nf --query "$PWD/messy_contigs/*.fasta" --db "$PWD/blastn_db/poliovirus/MZ245455" --contigs "$PWD/messy_contigs/*.fasta" --annot "$PWD/annotated/" --intermediate "$PWD/intermediate/"`
