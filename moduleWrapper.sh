#!/usr/bin/bash

## edit export PATH=$PATH:/path/to/my/nextflow/:/path/to/my/blast+/

if [[ -d ~/.bash.d ]]; then
    echo "export PATH=$PATH:/apps/x86_64/bio/nextflow/24.10.4/:/apps/x86_64/BLAST+/2.13.0-gompi-2022a/bin/" >> ~/.bash.d/nextflow.bash
    echo "alias llA='ll nextflow'" >> ~/.bash.d/nextflow.bash
else
    mkdir ~/.bash.d
    echo "export PATH=$PATH:/apps/x86_64/bio/nextflow/24.10.4/:/apps/x86_64/BLAST+/2.13.0-gompi-2022a/bin/" >> ~/.bash.d/nextflow.bash    
    echo "alias llA='ll nextflow'" >> ~/.bash.d/nextflow.bash
fi
