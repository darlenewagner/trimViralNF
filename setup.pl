#!/usr/bin/perl
use strict;
use warnings;
use Cwd;

my $current_dir = getcwd;
print "Creating folders, annotated\/, intermediate\/, messy_contigs\/, and blastn_output\/ in ",  $current_dir, ".\n";

sleep(1);

print "The current permissions are: ", umask(), "\n";

if(-d $current_dir."\/annotated/")
  { 
     warn "Folder 'annotated\/' already exists.\n";
  }
else
  {
      mkdir $current_dir."\/annotated/";
      chmod 0755, $current_dir."\/annotated/";
  }

sleep(1);

if(-d $current_dir."\/intermediate")
  { 
     warn "Folder 'intermediate\/' already exists.\n";
  }
else
  {
      mkdir $current_dir."\/intermediate";
      chmod 0755, $current_dir."\/intermediate";
  }

sleep(1);

if(-d $current_dir."\/messy_contigs/")
  { 
     warn "Folder 'messy_contigs\/' already exists.\n";
  }
else
  {
      mkdir $current_dir."\/messy_contigs/";
      chmod 0755, $current_dir."\/messy_contigs/";
  }

sleep(1);

if(-d $current_dir."\/blastn_output/")
  { 
     warn "Folder 'blastn_output\/' already exists.\n";
  }
else
  {
      mkdir $current_dir."\/blastn_output/";
      chmod 0755, $current_dir."\/blastn_output/";
  }

sleep(1);

exit;




