package TestUnihan;

# ABSTRACT: slurp and normalize the unihan database
package Unihan::Normalize::Slurp;
# VERSION
use strict;
use warnings;

use feature 'switch';
use Data::Dumper;
use Carp;

use base qw(Exporter);
our @EXPORT_OK = qw(slurp_fh);

__PACKAGE__->slurp_dir(@ARGV) unless caller;

sub slurp_dir {
	#TODO: allow usage of Unihan.zip instead
	my ($unihan_dir) = @_;
	my @files = glob ($unihan_dir . '/*.txt');
	
}

#slurp the incoming filehandle into a normalized hash
sub slurp_fh {
	my ($input_FH, $unihan) = @_;
	$unihan ||= {};
	
	my ($code, $field, $value, $extra);
	while (<$input_FH>){
		($code, $field, $value, $extra) = split "\t", $_;
		#make sure there were only three fields
		!defined $extra 
			or die "There was extra content at the end of line $.!";
		
		$field =~ s/^k//;
		chomp $value;
		$value = process_field($field, $value);
		$code =~ s/^U\+//;
		$unihan->{hex($code)}->{$field} = $value;
	}
	
	return $unihan;
}

sub process_field {
	my ($field, $value) = @_;
	given($field){
		### numeric fields; convert strings to numbers
		#kPrimaryNumeric- the numeric value of a character. 一, 二, 三 = 1, 2, 3, etc.
		when('PrimaryNumeric'){
			return 1*$value;
		}
		#kAccountingNumeric- used as in number in financial documents. 拾 = 10, etc
		when('AccountingNumeric'){
			return 1*$value;
		}
		#kOtherNumeric- used as a number in special cases (or just almost never used). 亖 = 4, 什 = 10, 㭍 = 7, etc
		when('OtherNumeric'){
			return 1*$value;
		}
		
		### IRG fields- store plain strings
		#kIICore- IRG-declared minimal set of chars for use in East Asia
		when('IICore'){
			return $value;
		}
		#kIRG_GSource- various standards in PRC and Singapore
		when('IRG_GSource'){
			#todo- this may need to be split on a dash in the future
			return $value;
		}
		#kIRG_HSource- Hong Kong Supplementary Character Set – 2008
		when('IRG_HSource'){
			#todo- this may need to be split on a dash in the future
			return $value;
		}
		#kIRG_JSource- Japan
		when('IRG_JSource'){
			#todo- this may need to be split on a dash in the future
			return $value;
		}
		#kIRG_KPSource- North Korea
		when('IRG_KPSource'){
			#todo- this may need to be split on a dash in the future
			return $value;
		}
		#kIRG_KSource- South Korea
		when('IRG_KSource'){
			#todo- this may need to be split on a dash in the future
			return $value;
		}
		#kIRG_MSource- Macao Information System Character Set (澳門資訊系統字集)
		when('IRG_MSource'){
			#todo- this may need to be split on a dash in the future
			return $value;
		}
		#kIRG_TSource- Taiwan
		when('IRG_TSource'){
			#todo- this may need to be split on a dash in the future
			return $value;
		}
		#kIRG_USource- U-source ideograph database submitted to IRG for inclusion by various parties, or placeholders for no-longer used glyphs
		#see http://www.unicode.org/reports/tr45
		when('IRG_USource'){
			#todo- this may need to be split on a dash in the future
			return $value;
		}
	}
}

#TODO: create an explain sub. This sub would give the meaning, in English, of a value for a field.