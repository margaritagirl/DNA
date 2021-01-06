print "enter the file name with dna sequence\n";
chomp($filename1=<STDIN>);
open(INFILE,$filename1);
print "enter the name of your first output file\n";
chomp($filename2=<STDIN>);
open(OUTFILE1,">$filename2");
@k=<INFILE>;
$x=$k[0];
$x =~ tr/a-z/A-Z/;
@b= split //,$x;
$n=$#b;
@d=('A','T','G','C');
$r=0;
foreach $_ (@d)
{
for($f=0,$w=0;($w=index($x,$_,$w))!=-1;$w++,$f++)
{
}
@nn=(@nn,$f);
for($l=1,$t=0;$l<=$nn[$r];$t++,$l++)
{
$possibility[$t]="$_"x$l;
@possibilities=(@possibilities,$possibility[$t]);
}
$r++;
for($t=1;$t<=$n;$t++)
{
$j="$_"x$t;
for($f=0,$w=0;($w=index($x,$j,$w))!=-1;$w++,$f++)
{
}
if($f != 0)
{
print OUTFILE1 $j," frequency is ",  $f,"\n\n";
@org_pair=(@org_pair,$j);
}
}
}
##########################now shuffling,comparing with shuffle and storing :)
print "enter the name of your second output file\n";
chomp($filename2=<STDIN>);
open(OUTFILE,">$filename2");
print OUTFILE "this is written in the order of pair,frequence in original sequence,mean, and z-value\n\n";
#####comparing with original
	for($k=0;$k<=$#possibilities;$k++)
        {
            for($f1=0,$w=0;($w=index($x,$possibilities[$k],$w))!=-1;$w++,$f1++)
                {
                }
         $org_frq[$k] =$f1,"\t";
	}
for($r=0;$r<=100;$r++)
{        ## creating a shuffled sequence        
	for($i=0;$i<$n;$i++)
	{
	$random = int(rand($n));
	$temp = $b[$random];
	$b[$random] = $b[$i];
	$b[$i] = $temp;
	}
         ##comparing with shuffled sequence
	$l=reverse reverse @b;
	@tmp=();
	for($k=0;$k<=$#possibilities;$k++)
        {
            for($f=0,$w=0;($w=index($l,$possibilities[$k],$w))!=-1;$w++,$f++)
                {
                }
         @tmp =(@tmp,$f);
	}
        $AoA[$r] = [@tmp];
}

######calculating frquency of each pair in each shufled sequence:)
for $i(0..$#AoA) 
{
$sum=0;
     for $j(0..99) 
	{
         $sum=$sum+$AoA[$j][$i];
	 }
@sums=(@sums,$sum);
 }
######calculating std deviation of each pair in each shufled sequence:)
for($k=0;$k<=$#possibilities;$k++)
{
for $i(0..$#AoA) 
{
$sd=0;
     for $j(0..99) 
	{
         $sd=$sd+($AoA[$j][$i]-$sums[$i]/100)**2;
	 }
@sd_s=(@sd_s,$sd);
 }
}
#####  writting :)
for($k=0;$k<=$#possibilities;$k++)
{
if ($org_frq[$k] == 0 && $sums[$k] == 0)
{
}
else
{
$s_d=sqrt($sd_s[$k]/100);
if($s_d==0)
{
$z_value=0;
}
else
{
$z_value=($org_frq[$k]-$sums[$k]/100)/$s_d;
}
print OUTFILE $possibilities[$k],"\t",$org_frq[$k],"\t",$sums[$k]/100,"\t",$z_value,"\n\n"; 
}
}
close INFILE;
close OUTFILE1;
close OUTFILE;

