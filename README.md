### Requires nextflow version 23.10.0 or higher

#### Example with all prerequisites available on server:
` nextflow run trimViralContigs.nf --query "$PWD/anonymousContigs/*.fasta" --db "$PWD/blastn_db/poliovirus/MZ245455" --annot "$PWD/annotated/" --intermediate "$PWD/intermediate/"`

#### Example with blastn and perl implemented through singularity:

