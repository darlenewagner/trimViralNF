#!/usr/bin/perl
use strict;
use warnings;
use Cwd;

my $current_dir = getcwd;
print "Creating folders, annotated\/, intermediate\/, messy_contigs\/, and blastn_output\/ in ",  $current_dir, ".\n";
sleep(1);
print "This script also validates paths to nextflow and blastn executables.";
print "To install nextflow and blastn, run './moduleWrapper.sh' followed by 'source ~/.bash.d/nextflow.bash'";

sleep(1);

#print "The current permissions are: ", umask(), "\n";

if(-d $current_dir."\/annotated/")
  { 
     warn "Folder 'annotated\/' already exists.\n";
  }
else
  {
      if(mkdir $current_dir."\/annotated/"){ print "Created annotated\/\n"; } else { warn "Unable to create annotated\/\n";}
      chmod 0755, $current_dir."\/annotated/";
  }

sleep(1);

if(-d $current_dir."\/intermediate")
  { 
     warn "Folder 'intermediate\/' already exists.\n";
  }
else
  {
      if(mkdir $current_dir."\/intermediate"){ print "Created intermediate\/\n"; } else { warn "Unable to create intermediate\/\n";}
      chmod 0755, $current_dir."\/intermediate";
  }

sleep(1);

if(-d $current_dir."\/anonymousContigs/")
  { 
     warn "Folder 'anonymousContigs\/' already exists.\n";
  }
else
  {
      if(mkdir $current_dir."\/anonymousContigs/"){ print "Created anonymousContigs\/\n"; } else { warn "Unable to create anonymousContigs\/\n";}
      chmod 0755, $current_dir."\/anonymousContigs/";
  }

sleep(1);

if(-d $current_dir."\/blastn_output/")
  { 
     warn "Folder 'blastn_output\/' already exists.\n";
  }
else
  {
      if(mkdir $current_dir."\/blastn_output/"){ print "Created blastn_output\/\n"; } else { warn "Unable to create blastn_output\/\n";}
      chmod 0755, $current_dir."\/blastn_output/";
  }

sleep(1);

if(-d $current_dir."\/messy_contigs/")
  {
       warn "Folder 'blastn_output\/' already exists.\n";
  }
else
 {
       if(mkdir $current_dir."\/messy_contigs/"){ print "Created messy_contigs\/\n"; } else { warn "Unable to create messy_contigs\/\n";}
       chmod 0755, $current_dir."\/messy_contigs/";
 }

sleep(1);

if(-e $current_dir."\/test_genomes.tar")
  {
      system("tar xvf test_genomes.tar");
     ## system("mv -v test_genomes\/*.fasta messy_contigs\/")
  }
else
 {
     warn "Archive, test_genomes.tar, not found.";
  }


my $nextflowy = `which nextflow`;


if($? == 0)
{
    print "Found nextflow path: $nextflowy\n";
}
else
{
    
    system("./moduleWrapper.sh");
    $nextflowy = `which nextflow`;
    if($? == 0)
    {
	print "Found nextflow path: $nextflowy\n";
	#my $see = `/usr/share/lmod/lmod/libexec/lmod perl load nextflow/24.10.4`;
	#    system("$see");
    }
    else
    {
        print "Nextflow executable or path not found!\nExit status: $?\n";
    }
}

my $blasty = `which blastn`;

if($? == 0)
{
    print "Found blastn path: $blasty\n";
}

exit;




