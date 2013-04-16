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
		#kIRG_VSource- Vietname
		when('IRG_VSource'){
			#todo- this may need to be split on a dash in the future
			return $value;
		}
		### Dictionary indices
		#todo- these may need to be split on dots in the future
		
		## official IRG indices
		
		# kIRGHanyuDaZidian- 1986 PRC dictionary used in four-dict sorting algorithm
		# volume.page.position[01] (1 means not actually in the dictionary but would be in this spot)
		when('IRGHanyuDaZidian'){
			return $value;
		}
		
		# kIRGKangXi- 《康熙字典》 Kang Xi Dictionary used in four-dict sorting algorithm
		# page.position[01] (1 means not acutally in the dictionary but would be in this spot)
		when('IRGKangXi'){
			return $value;
		}
		
		# kIRGDaeJaweon- Dae Jaweon (Korean) Dictionary used in four-dict sorting algorithm
		# page.position[01] (1 means not acutally in the dictionary but would be in this spot)
		when('IRGDaeJaweon'){
			return $value;
		}
		
		# kIRGDaiKanwaZiten- Index in the Dai Kanwa Ziten, aka Morohashi dictionary (Japanese) used in four-dict sorting algorithm
		when('IRGDaiKanwaZiten'){
			return $value;
		}
		
		## General Chinese dictionaries
		
		# kCihaiT- Cihai (辭海) general Chinese dictionary (Hong Kong 1983)
		# page.row.column
		#Provisional- no data yet
		when('CihaiT'){
			return undef;
		}
		
		# kFennIndex- Location in Fenn’s Chinese-English Pocket Dictionary (by Courtenay H. Fenn, 1942)
		# page.position
		when('FennIndex'){
			return $value;
		}
		
		# kGSR- position in Bernhard Karlgren’s Grammata Serica Recensa (1957), minus inscriptional forms
		# [0001..1260][a-vx-z]'?
		when('GSR'){
			return $value;
		}
		
		# kKarlgren- index in "Analytic Dictionary of Chinese and Sino-Japanese" by Bernhard Karlgren (1974)
		# 1-9][0-9]{0,3}[A*]? (* indicates non-actual presence in the dictionary)
		when('Karlgren'){
			return $value;
		}
		
		# kMatthews- index in the Mathews’ Chinese-English Dictionary by Robert H. Mathews (1975)
		# [1-9][0-9]{0,3}(a|\.5)?
		when('Matthews'){
			return $value;
		}
		
		# kSBGY- position in the Song Ben Guang Yun (SBGY) Medieval Chinese character dictionary
		# page.position
		when('SBGY'){
			if($value =~ /\s/){
				return [split(/\s/, $value)];
			}
			return $value;
		}
		
		##Cantonese dictionaries
		
		# kCheungBauerIndex- position in "The Representation of Cantonese with Chinese Characters" by Cheung Kwan-hin and Robert S. Bauer
		# page.position
		when('CheungBauerIndex'){
			return $value;
		}
		
		# kCowles- index in A Pocket Dictionary of Cantonese Roy T. Cowles
		when('Cowles'){
			if($value =~ /\s/){
				return [split(/\s/, $value)];
			}
			return $value;
		}
		
		# kLau- index in "A Practical Cantonese-English Dictionary" by Sidney Lau
		when('Lau'){
			if($value =~ /\s/){
				return [split(/\s/, $value)];
			}
			return $value;
		}
		
		# kMeyerWempe- index in "Student’s Cantonese-English Dictionary" by Bernard F. Meyer and Theodore F. Wempe (1947)
		# \d+[a-t*]? (letter indicates location in subsidiary, * indicates location in radical index but not main text)
		when('MeyerWempe'){
			if($value =~ /\s/){
				return [split(/\s/, $value)];
			}
			return $value;
		}
		
		# kNelson- index in "The Modern Reader’s Japanese-English Character Dictionary" by Andrew Nathaniel Nelson
		when('Nelson'){
			if($value =~ /\s/){
				return [split(/\s/, $value)];
			}
			return $value;
		}

		### Readings
		# kCantonese- Cantonese pronunciation, using jyutping romanization (multiples are sorted alphabetically)
		when('Cantonese'){
			if($value =~ /\s/){
				return [split(/\s/, $value)];
			}
			return $value;
		}

		# kDefinition- English definition of character in modern Chinese (or another language as noted). 
		# Also synonymns. Major defs separated by semicolon, minor by comma
		when('Definition'){
			return $value;
		}

		# kHangul- Modern Korean pronunciation. Do they distinguish Sino-Korean here?
		when('Hangul'){
			if($value =~ /\s/){
				return [split(/\s/, $value)];
			}
			return $value;
		}

		# kHangul- Modern Chinese in Pinyin, plus a frequency number, provided by 現代漢語頻率詞典
		when('HanyuPinlu'){
			if($value =~ /\s/){
				return [split(/\s/, $value)];
			}
			return $value;
		}
		
		# kHanyuPinyin- locations and associated pinyins in 漢語大字典. 
		when('HanyuPinyin'){
			if($value =~ /\s/){
				return [map {process_hanyu($_)} split(/\s/, $value)];
			}
			return process_hanyu($value);
		}

		default {
			die "unknown key: $_";
		}
	}
}

# Return {location => [pinyin]}
sub process_hanyu{
	my ($value) = @_;
	$value =~ 
	/
		((?:\d{5}\.\d{2}0,?)+)							#comma-separated locations in dictionary
		:												#followed by a colon, and then
		((?:[^,]+,?)+)									#comma-separated pinyin
	/x;
	return {
		$1 => [split ',', $2]
	};
}

#TODO: create an explain sub. This sub would give the meaning, in English, of a value for a field.