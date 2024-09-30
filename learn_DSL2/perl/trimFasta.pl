use strict;
use warnings;
use integer;

## cut fasta sequence at coordinates provided in header

my $fasta = $ARGV[0];

open(FASTA, $fasta) || die "Can't find fasta-formatted input file, $fasta $!";

my $header = '';
my $trim = 0;
my $offset = 0;
my $newLength = 0;
my $DNA = '';

while(<FASTA>)
{
    if($_ =~ /^>/)
    {
	my @newHeader = split(" ", $_);
	my $trimString = scalar @newHeader - 1;
	
	# print $newHeader[$trimString], "\n";
	($trim, $offset) = split("_", $newHeader[$trimString]);
	$newLength = $offset - $trim;
        $header = $newHeader[0]." ".$newHeader[1]." length=".$newLength."\n";
	#print $trim, " ", $offset, "\n";
    }
    elsif($_ =~ /^(A|C|G|N|T)/)
    {
	chomp;
	$DNA = $DNA.$_;
    }
}

print $header;
my $newDNA = substr($DNA, $trim, $newLength);

my $limit = int(length($newDNA)/60) + 1;

  #print $limit, "\n";

for(my $l = 0; $l < $limit; $l++)
  {
     print substr($newDNA, $l*60, 60), "\n";  
  }   

close(FASTA)


