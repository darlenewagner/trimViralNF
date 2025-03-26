#!/usr/bin/bash

## edit export PATH=$PATH:/path/to/my/nextflow/:/path/to/my/blast+/

perl setup.pl

if [[ -d ~/.bash.d ]]; then
    echo "#!/usr/bin/bash"
    echo "export PATH=/apps/x86_64/Perl/5.30.1-GCCcore-9.3.0-mt/bin/:/apps/x86_64/Java/java-21.0.5/bin/:$PATH:/apps/x86_64/bio/nextflow/24.10.4/:/apps/x86_64/BLAST+/2.13.0-gompi-2022a/bin/" >> ~/.bash.d/nextflow.bash
    echo "alias llA='ll nextflow'" >> ~/.bash.d/nextflow.bash
else
    mkdir ~/.bash.d
    echo "#!/usr/bin/bash"
    echo "export PATH=/apps/x86_64/Perl/5.30.1-GCCcore-9.3.0-mt/bin/:/apps/x86_64/Java/java-21.0.5/bin/:$PATH:/apps/x86_64/bio/nextflow/24.10.4/:/apps/x86_64/BLAST+/2.13.0-gompi-2022a/bin/" >> ~/.bash.d/nextflow.bash
    echo "alias llA='ll nextflow'" >> ~/.bash.d/nextflow.bash
fi

##chmod +x ~/.bash.d/nextflow.bash
