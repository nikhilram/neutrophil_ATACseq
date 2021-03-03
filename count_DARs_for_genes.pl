#!/usr/bin/perl
use warnings;

$file = $ARGV[0];
if (not defined $file){die "usage: <count_DARs_for_genes.pl>\n count_DARs_for_genes.pl input\n"};
open(CMs, $file);
while($line = <CMs>){
        chomp $line;
    if($line =~ m/^V/){
        next;
    } else {
        my @chunks;
        @chunks = split /\t/, $line;
        $gene = $chunks[1];
	$ge = $chunks[2];
#        $ge = $chunks[4];
	$pe = $chunks[3];
        $hits{$gene}{_ge}=$ge;
	if($pe=~/closed1h/){
		$hits{$gene}{_closed1h}++;
	} elsif($pe=~/closed4h/){
		$hits{$gene}{_closed4h}++;
		} elsif($pe=~/open1h/){
			$hits{$gene}{_open1h}++;
			} elsif($pe=~/open4h/){
				$hits{$gene}{_open4h}++;
				} else {next;}


    }
}
@hits = sort keys %hits;
print "GeneID\tGene_expression\tOpen1h\tClosed1h\tOpen4h\tClosed4h\n";
for $n (@hits){
	$gex = $hits{$n}{_ge};
	$closed1h = $hits{$n}{_closed1h} || 0;
	$closed4h = $hits{$n}{_closed4h} || 0;
	$open1h = $hits{$n}{_open1h} || 0;
	$open4h = $hits{$n}{_open4h} || 0;
	$closed1hneg = -1 * $closed1h;
        $closed4hneg = -1 * $closed4h;
	print "$n\t$gex\t$open1h\t$closed1hneg\t$open4h\t$closed4hneg\n";
}

close CMs;

exit;

