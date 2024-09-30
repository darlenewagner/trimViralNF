use strict;

## cut fasta sequence at coordinates provided in header

my $fasta = $ARGV[0];

open(FASTA, $fasta) || die "Can't find fasta-formatted input file, $fasta $!";

while(<FASTA>)
{
    if($_ =~ /^>/)
    {
	my @newHeader = split $trimmer, $_;
	print $newHeader[0], "\n";
    }
    else
    {
       print $_;
    }
}

close(FASTA)

