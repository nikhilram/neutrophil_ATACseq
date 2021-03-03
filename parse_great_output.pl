#!/usr/bin/perl
use warnings;

$file = $ARGV[0];
if (not defined $file){die "usage: <parse_great_output.pl>\n parse_great_output.pl input\n"};
open(CMs, $file);
while($line = <CMs>){
        chomp $line;
    if($line =~ m/#/){
        next;
    } elsif($line=~/^$/){
	next;
	} else {
        my @chunks;
	$line =~ s/ +/\t/g;
	$line =~ s/,/\t/g;	
        @chunks = split /\t/, $line;
        $peak = shift @chunks;
	foreach $n (@chunks){
		if($n =~ m/NONE/){next;}
		elsif($n=~m/\(.*\)/){next;}
		elsif($n=~/^$/){next;}
		else {
	print "$peak\t$n\n";
	}
		}
	}
}
close CMs;

exit;

