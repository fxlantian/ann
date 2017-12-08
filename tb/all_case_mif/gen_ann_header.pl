#!/usr/local/bin/perl

use Getopt::Long qw(GetOptions);

GetOptions(
 #'dir|d=s'  => \$strDir,
 'testcase=s' =>\$casename,

);

$strDir = ".";
$count  = 1;

open (OUT,">$strDir" . "/../../sw/apps/testANN/testANN.h")||die "could not open file!\n";
#open (OUTV,">$strDir" . "/../init_mem.v")||die "could not open file!\n";

sub lineCnt{
	my ($file) = @_; 
	my $lineCnt = 0;
	my @dataGroup;
	my $i;
	open (INF,$file)||die "could not open file! $file\n"; 
	while($lineItem = <INF>)
	{
		if(defined($lineItem)){
			  $lineCnt = $lineCnt+1;
			  chomp($lineItem);
			  push(@dataGroup,$lineItem); 
			}			
		}
		close(INF);
		
	for($i=$lineCnt-1; $i>0; $i--){
		
		#$num = ord($dataGroup[$i]);
		#print "$num\n";
		#last;
		if(($dataGroup[$i] ne "00") && ($dataGroup[$i] ne "")  )
		{
			
			last;
		} else {
				  $lineCnt = $lineCnt - 1;
			}
		}
		
		return $lineCnt;
	}

sub mending4{
	my ($cnt) = @_;   
	while($cnt % 4 > 0)
		{
			 $cnt = $cnt + 1;
			}
		#print "$cnt\n";  
		return $cnt;
	}

opendir(THISDIR, ".") or die "serious dainbramage: $!";

@allfiles = grep { not /^*\.pl\z/ and  not /^\.{1,2}\z/} readdir THISDIR;

closedir THISDIR;

my $init_src_addr= 0;
my $outputCnt  = 0;
my $inputCnt   = 0;
my $insnCnt    = 0;
my $biasCnt    = 0;
my $weightCnt  = 0;
my $sigCnt     = 0;
my $testcnt    = 0;
my $cnt_parse  = 0;
#print OUTV "reg [31:0] i;\n";   
#print OUTV "reg [31:0] j;\n";

foreach (@allfiles){
	$testcase = $_;
	if((-d $testcase) && ($testcase =~ m/$casename/)){
			print "convert $testcase\n";
		
			my $inputdataF     =  "$strDir/$testcase/meminit_input_vectors.mif";
			my $outputdataF    =  "$strDir/$testcase/meminit_output_vectors.mif";
			my $insndataF      =  "$strDir/$testcase/meminit_insn.mif";	
			my $biasdataF      =  "$strDir/$testcase/meminit_offset.mif";
			my $weightdataF    =  "$strDir/$testcase/meminit_w00.mif"; 
			my $weightdataF1    =  "$strDir/$testcase/meminit_w01.mif";
			my $weightdataF2    =  "$strDir/$testcase/meminit_w02.mif";
			my $weightdataF3    =  "$strDir/$testcase/meminit_w03.mif";
			my $weightdataF4    =  "$strDir/$testcase/meminit_w04.mif";
			my $weightdataF5    =  "$strDir/$testcase/meminit_w05.mif";
			my $weightdataF6    =  "$strDir/$testcase/meminit_w06.mif";
			my $weightdataF7    =  "$strDir/$testcase/meminit_w07.mif";
			my $sigdataF       =  "$strDir/$testcase/sigmoid.mif";
			#my $weightdataFstr =  "$strDir/$testcase/meminit_w";
			
			
			open (W0FILE,$weightdataF)||die "could not open file! $weightdataF\n";
			open (W1FILE,$weightdataF1)||die "could not open file! $weightdataF\n";
			open (W2FILE,$weightdataF2)||die "could not open file! $weightdataF\n";
			open (W3FILE,$weightdataF3)||die "could not open file! $weightdataF\n";
			open (W4FILE,$weightdataF4)||die "could not open file! $weightdataF\n";
			open (W5FILE,$weightdataF5)||die "could not open file! $weightdataF\n";
			open (W6FILE,$weightdataF6)||die "could not open file! $weightdataF\n";
			open (W7FILE,$weightdataF7)||die "could not open file! $weightdataF\n";
			open (SIGFILE,$sigdataF)||die "could not open file! $sigdataF\n";
			open (OFFFILE,$biasdataF)||die "could not open file! $biasdataF\n";
			open (INSNFILE,$insndataF)||die "could not open file! $insndataF\n";
			open (ODATAFILE,$outputdataF)||die "could not open file! $outputdataF\n"; 
			open (IDATAFILE,$inputdataF)||die "could not open file! $inputdataF\n";
			
			print "data load complete\n";

			 $outputCnt  = &lineCnt($outputdataF );
			 $inputCnt   = &lineCnt($inputdataF );
			 $insnCnt    = &lineCnt($insndataF  );
			 $biasCnt    = &lineCnt($biasdataF  );
			 $biasCnt    = &mending4($biasCnt);
			 $weightCnt  = &lineCnt($weightdataF);
			 $weightCnt  = &mending4($weightCnt);
			 $sigCnt     = 512;
 			
 			my $weight_length = $weightCnt/4;
			my $offset_length = $biasCnt/4;

 			$wrtStr =         " #define  IM_DEPTH$testcnt            $insnCnt\n";
 			$wrtStr = $wrtStr." #define  WEIGTH_DEPTH$testcnt        $weightCnt\n";
 			$wrtStr = $wrtStr." #define  BIAS_DEPTH$testcnt          $biasCnt\n";
 			$wrtStr = $wrtStr." #define  DMA_BLOCK_INFO$testcnt      1\n\n";
 			$wrtStr = $wrtStr." #define  NPU_DATAIN_DEPTH$testcnt    $inputCnt\n";
 			$wrtStr = $wrtStr." #define  NPU_DATAOUT_DEPTH$testcnt   $outputCnt\n";
 			$wrtStr = $wrtStr." #define  NPU_DMA_BLOCK_INFO$testcnt  1\n\n\n";
 			$wrtStr = $wrtStr." #define  length_array_weight  		 $weight_length\n";
			$wrtStr = $wrtStr." #define  length_array_offset  		 $offset_length\n\n\n";

			print OUT $wrtStr;
			print "output config array\n";
			print OUT "int Ann_Config[]={\n";
			print OUT "//instruction-------\n";
			 for($convert_cnt = 0; $convert_cnt < $insnCnt; $convert_cnt++)
			 {
			 		$strinsn = <INSNFILE>;
			 		chomp($strinsn);
			 		$strinsn_dec = oct('0b'.$strinsn );
			 		$strinsn_hex = sprintf("%#.8x,\n",$strinsn_dec);
			 		print OUT $strinsn_hex;	
			 	}			 	
			close(INSNFILE);
 			
			print OUT "//W0FILE-------\n";
			for($convert_cnt = 0; $convert_cnt < $weightCnt; $convert_cnt+=4)
			{
					$strw0 = <W0FILE>;
					$strw1 = <W0FILE>;
					$strw2 = <W0FILE>;
					$strw3 = <W0FILE>;

					chomp($strw0);
			 		chomp($strw1);
			 		chomp($strw2);
			 		chomp($strw3);

					$strw = $strw3.$strw2.$strw1.$strw0;

			 		print OUT "0x$strw,\n";
			}
			close(W0FILE);

			print OUT "//W1FILE-------\n";
			for($convert_cnt = 0; $convert_cnt < $weightCnt; $convert_cnt+=4)
			{
					$strw0 = <W1FILE>;
					$strw1 = <W1FILE>;
					$strw2 = <W1FILE>;
					$strw3 = <W1FILE>;

					chomp($strw0);
			 		chomp($strw1);
			 		chomp($strw2);
			 		chomp($strw3);

					$strw = $strw3.$strw2.$strw1.$strw0;

			 		print OUT "0x$strw,\n";
			}
			close(W1FILE);

			print OUT "//W2FILE-------\n";
			for($convert_cnt = 0; $convert_cnt < $weightCnt; $convert_cnt+=4)
			{
					$strw0 = <W2FILE>;
					$strw1 = <W2FILE>;
					$strw2 = <W2FILE>;
					$strw3 = <W2FILE>;

					chomp($strw0);
			 		chomp($strw1);
			 		chomp($strw2);
			 		chomp($strw3);

					$strw = $strw3.$strw2.$strw1.$strw0;

			 		print OUT "0x$strw,\n";
			}
			close("W2FILE");

			print OUT "//W3FILE-------\n";
			for($convert_cnt = 0; $convert_cnt < $weightCnt; $convert_cnt+=4)
			{
					$strw0 = <W3FILE>;
					$strw1 = <W3FILE>;
					$strw2 = <W3FILE>;
					$strw3 = <W3FILE>;

					chomp($strw0);
			 		chomp($strw1);
			 		chomp($strw2);
			 		chomp($strw3);

					$strw = $strw3.$strw2.$strw1.$strw0;

			 		print OUT "0x$strw,\n";
			}
			close(W3FILE);

			print OUT "//W4FILE-------\n";
			for($convert_cnt = 0; $convert_cnt < $weightCnt; $convert_cnt+=4)
			{
					$strw0 = <W4FILE>;
					$strw1 = <W4FILE>;
					$strw2 = <W4FILE>;
					$strw3 = <W4FILE>;

					chomp($strw0);
			 		chomp($strw1);
			 		chomp($strw2);
			 		chomp($strw3);

					$strw = $strw3.$strw2.$strw1.$strw0;

			 		print OUT "0x$strw,\n";
			}
			close(W4FILE);

			print OUT "//W5FILE-------\n";
			for($convert_cnt = 0; $convert_cnt < $weightCnt; $convert_cnt+=4)
			{
					$strw0 = <W5FILE>;
					$strw1 = <W5FILE>;
					$strw2 = <W5FILE>;
					$strw3 = <W5FILE>;

					chomp($strw0);
			 		chomp($strw1);
			 		chomp($strw2);
			 		chomp($strw3);

					$strw = $strw3.$strw2.$strw1.$strw0;

			 		print OUT "0x$strw,\n";
			}
			close(W5FILE);

			print OUT "//W6FILE-------\n";
			for($convert_cnt = 0; $convert_cnt < $weightCnt; $convert_cnt+=4)
			{
					$strw0 = <W6FILE>;
					$strw1 = <W6FILE>;
					$strw2 = <W6FILE>;
					$strw3 = <W6FILE>;

					chomp($strw0);
			 		chomp($strw1);
			 		chomp($strw2);
			 		chomp($strw3);

					$strw = $strw3.$strw2.$strw1.$strw0;

			 		print OUT "0x$strw,\n";
			}
			close(W6FILE);

			print OUT "//W7FILE-------\n";
			for($convert_cnt = 0; $convert_cnt < $weightCnt; $convert_cnt+=4)
			{
					$strw0 = <W7FILE>;
					$strw1 = <W7FILE>;
					$strw2 = <W7FILE>;
					$strw3 = <W7FILE>;

					chomp($strw0);
			 		chomp($strw1);
			 		chomp($strw2);
			 		chomp($strw3);

					$strw = $strw3.$strw2.$strw1.$strw0;

			 		print OUT "0x$strw,\n";
			}
			close(W7FILE);

			print OUT "//OFFSET-------\n";
			for($convert_cnt = 0; $convert_cnt < $biasCnt; $convert_cnt+=4)
			{
					$stroff0 = <OFFFILE>;
					$stroff1 = <OFFFILE>;
					$stroff2 = <OFFFILE>;
					$stroff3 = <OFFFILE>;

					chomp($stroff0);
			 		chomp($stroff1);
			 		chomp($stroff2);
			 		chomp($stroff3);

					$stroff = $stroff3.$stroff2.$stroff1.$stroff0;

			 		print OUT "0x$stroff,\n";
			}

			close(OFFFILE);
			
			for($convert_cnt = 0; $convert_cnt < $sigCnt; $convert_cnt+=4)
			{
					$strsig0 = <SIGFILE>;
					$strsig1 = <SIGFILE>;
					$strsig2 = <SIGFILE>;
					$strsig3 = <SIGFILE>;

					chomp($strsig0);
			 		chomp($strsig1);
			 		chomp($strsig2);
			 		chomp($strsig3);

					$strsig = $strsig3.$strsig2.$strsig1.$strsig0;

			 		print OUT "0x$strsig,\n";
			}
			close(SIGFILE);
			seek OUT, -2, 1;
			print OUT "\n};\n";
			print "output data_input array\n";
			print OUT "\nint data_input[]={\n";
			for($convert_cnt = 0; $convert_cnt < $inputCnt; $convert_cnt++)
			{
					$stridata = <IDATAFILE>;
					chomp($stridata);
			 		print OUT "0x$stridata,\n";
			}
			close(IDATAFILE); 
			seek OUT, -2, 1;
			print OUT "\n};\n";
			print "output data_check array\n";
			print OUT "\nint data_check[]={\n";
			for($convert_cnt = 0; $convert_cnt < $outputCnt; $convert_cnt++)
			{
					$strodata = <ODATAFILE>;
					chomp($strodata);
			 		print OUT "0x$strodata,\n";
			}
			close(ODATAFILE); 
			seek OUT, -2, 1;
			print OUT "\n};\n";
       		$testcnt++;      
	}
}
close(OUT);










