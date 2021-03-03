#!/usr/bin/perl
use warnings; 

############### Script to comnine the genes associated with peaks and the output from the bedtools search for peaks within promoters (TSS +- 2.5Kb).
############### Peak in promoter region is considered for each gene only if the peak is associated to the gene by any of the methods of association used.
  
@files = @ARGV; 
$a = $files[0]; 
open (S1, $a); 
while ($line=<S1>){ 
       chomp $line; 
       my @chunks;
       @chunks = split /\t/, $line;
		$peak_id = $chunks[0];
		$associated_gene = $chunks[1];
		$status = $chunks[2];		
    $genes{$associated_gene}{_associated}{$peak_id} = 1;
		if ($status =~ m/open/){
			$genes{$associated_gene}{_open}++;
			} else {
                        $genes{$associated_gene}{_closed}++;
			}
		} 
	

shift (@files);
foreach $n (@files){
open (S2, $n) or die "can't open$n\n";
while ($line=<S2>){
       chomp $line;
       my @chunks;
       @chunks = split /\t/, $line;
	$ids = $chunks[13];
	$tss_gene = $chunks[14];
	$genes{$tss_gene}{_promoter}{$ids}=1;	
	}

}

print "Gene_name\tPromoter_peaks\tDistal_peaks\tInduced\tRepressed\n";
foreach $n (keys %genes){
	$tss = 0;
	if (keys %{$genes{$n}{_promoter}} > 0){
	foreach $m (keys %{$genes{$n}{_promoter}}){
	if (exists $genes{$n}{_associated}{$m}){
		$tss++;
		$size = keys $genes{$n}{_associated};
		$distal = $size - $tss;
		} else {
			$distal = keys $genes{$n}{_associated};
		}
	}
	} else {
	$distal = keys $genes{$n}{_associated};
	}
	$open = $genes{$n}{_open} || 0;
        $closed = $genes{$n}{_closed} || 0;	
	print "$n\t$tss\t$distal\t$open\t$closed\n";
}



