### Requires nextflow version 23.10.0 or higher

#### Example:
` nextflow run trimViralContigs.nf --query "$PWD/anonymousContigs/*.fasta" --db "$PWD/blastn_db/poliovirus/MZ245455" --annot "$PWD/annotated/" --intermediate "$PWD/intermediate/"`
