#!/usr/bin/perl
use warnings;

$file = $ARGV[0];
if (not defined $file){die "usage: <join_peaks_genes.pl>\n join_peaks_genes.pl associated_genes peaks_bed_file\n"};
open(CMs, $file);
while($line = <CMs>){
        chomp $line;
    if($line =~ m/^V/){
        next;
    } else {
        my @chunks;
        @chunks = split /\t/, $line;
        $peak = $chunks[0];
	$ge = $chunks[1];
	$hits{$peak}{_genes}{$ge} = 1;
    }
}


$file2 = $ARGV[1];
open(BED, $file2);
while($line1 = <BED>){
	chomp $line1;
	my @chunks1;
	@chunks1 = split /\t/, $line1;
	$chr = $chunks1[0];
	$start = $chunks1[1];
	$end = $chunks1[2];
	$peakid = $chunks1[3];
	@genes = ();
	if(keys %{$hits{$peakid}{_genes}} > 0 ){
		foreach $keys (keys %{$hits{$peakid}{_genes}}){
			push(@genes,$keys);
		}
		
	} else {next;}
	print "$chr\t$start\t$end\t$peakid\t";
	print join(',' , @genes), "\n";
}



close CMs;

exit;

