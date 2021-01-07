print "enter the dna sequence\n";
chomp($org1=<STDIN>);
@org=split //,$org1;
print "enter the number of mutations\n";
chomp($n=<STDIN>);
@pair=("A","T","G","C");
sub insertion
	{
	splice(@org,$org[int(rand($#org))],0,$pair[int(rand(3))]);
	}
sub deletion
	{
	delete $org[int(rand($#org))];
	}
sub substitution
	{
	$temp=int(rand($#org));
	delete $org[$temp];
	$org[$temp]=$pair[int(rand(3))];
	}
sub mutation
{
print @org,"\n";
for($j=0;$j<$n;$j++)
	{
		
		my $e= int(rand(3));
		if($e==0){&insertion;}
		if($e==1){&deletion;}
		if($e==2){&substitution;}
		
	}
	@b=@org;
	$b1=join('',@org);
	print @org,"\n";
}
&mutation;
#RUN THROUGH THE MUTATED STRING CHECK EACH LOCATION FOR SUBSTITUTION,DELETION,INSERTION
#BY CHECKING WHAT HAPPEND AT EACH LOCATION BY MATCHING WITH ORIGINAL
#ASSUMPTION:: ONLY ONE MUTATION HAS HAPPEND AT A LOCATION
for($i=1;$i<=$#b;$i++)
{
$s=substr($b1,$i,1);
$s1=substr($b1,$i+1,1);
$s2=substr($b1,$i-1,1);
$l=substr($org1,$i,1);
$l1=substr($org1,$i+1,1);
$l2=substr($org1,$i-1,1);
$o=$l2.$l.$l1;
if($o =~ /$s2$s$s1/){$j++;}
else
{
if ($o =~ /$s2$s1/){print "location $i undergone deletion","\n";}
elsif ($o =~ /$s2$s.$s1/|| $o =~ /$s2.$s$s1/){print "location $i undergone addition","\n";}
else{print "location $i undergone substitution","\n";}
}
}

