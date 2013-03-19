# check that dictionary indices are handled properly
# see http://www.unicode.org/reports/tr38/tr38-13.html#N1013C
# includes: 
# official IRG indices: kIRGHanyuDaZidian kIRGKangXi kIRGDaeJaweon kIRGDaiKanwaZiten
# general purpose Chinese: kCihaiT kFennIndex kGSR kKarlgren kMatthews kSBGY
# Cantonese: kCheungBauerIndex kCowles kLau kMeyerWempe
# other: kNelson

use t::TestConverter;
use Test::More 0.88;
plan tests => 1 * blocks();

filters {
	input => 'slurp',
	expected => 'eval',
};

# slurp each of the blocks into a unihan structure and check the output
for my $block (blocks()) {
	is_deeply($block->input, $block->expected, $block->name)
		or note explain $block->input;
}

__DATA__
=== kIRGHanyuDaZidian field is properly processed
--- input
U+3400	kIRGHanyuDaZidian	10015.030
U+35CF	kIRGHanyuDaZidian	10652.011
---  expected
{
  '13312' => {
    'IRGHanyuDaZidian' => '10015.030'
  },
  '13775' => {
    'IRGHanyuDaZidian' => '10652.011'
  }
}

=== kIRGKangXi field is properly processed
--- input
U+35CF	kIRGKangXi	0201.121
U+35D4	kIRGKangXi	0201.180
---  expected
{
  '13775' => {
    'IRGKangXi' => '0201.121'
  },
  '13780' => {
    'IRGKangXi' => '0201.180'
  }
}

=== kIRGDaeJaweon field is properly processed
--- input
U+4E00	kIRGDaeJaweon	0129.010
U+4E37	kIRGDaeJaweon	0162.211
---  expected
{
  '19968' => {
    'IRGDaeJaweon' => '0129.010'
  },
  '20023' => {
    'IRGDaeJaweon' => '0162.211'
  }
}

=== kIRGDaiKanwaZiten field is properly processed
--- input
U+4E38	kIRGDaiKanwaZiten	00094
---  expected
{
  '20024' => {
    'IRGDaiKanwaZiten' => '00094'
  }
}

=== kFennIndex field is properly processed
--- input
U+348B	kFennIndex	480.05
---  expected
{
  '13451' => {
    'FennIndex' => '480.05'
  }
}

=== kGSR field is properly processed
--- input
U+34B8	kGSR	0526a
U+34E0	kGSR	0618m
U+3754	kGSR	1166z
---  expected
{
  '13496' => {
    'GSR' => '0526a'
  },
  '13536' => {
    'GSR' => '0618m'
  },
  '14164' => {
    'GSR' => '1166z'
  }
}

=== kKarlgren field is properly processed
--- input
U+3795	kKarlgren	189
U+7635	kKarlgren	1052*
U+811A	kKarlgren	506A
---  expected
{
  '14229' => {
    'Karlgren' => '189'
  },
  '30261' => {
    'Karlgren' => '1052*'
  },
  '33050' => {
    'Karlgren' => '506A'
  }
}

=== kMatthews field is properly processed
--- input
U+811A	kMatthews	1177
U+8178	kMatthews	220
U+83F8	kMatthews	7397a
U+752D	kMatthews	5047.5
---  expected
{
  '29997' => {
    'Matthews' => '5047.5'
  },
  '33050' => {
    'Matthews' => '1177'
  },
  '33144' => {
    'Matthews' => '220'
  },
  '33784' => {
    'Matthews' => '7397a'
  }
}

=== kSBGY field is properly processed
--- input
U+7530	kSBGY	134.25
U+7536	kSBGY	475.32
U+753A	kSBGY	197.18 288.26 319.53 320.07
---  expected
{
  '30000' => {
    'SBGY' => '134.25'
  },
  '30006' => {
    'SBGY' => '475.32'
  },
  '30010' => {
    'SBGY' => [qw(197.18 288.26 319.53 320.07)]
  }
}

=== kCowles field is properly processed
--- input
U+28256	kCowles	2882
U+29DAC	kCowles	3907.5
U+26761	kCowles	1296 1308
U+24DEB	kCowles	4733 4744.5
U+21148	kCowles	392.08
U+21121	kCowles	70
---  expected
{
 '135457' => {
   'Cowles' => '70'
 },
 '135496' => {
   'Cowles' => '392.08'
 },
 '151019' => {
   'Cowles' => [
     '4733',
     '4744.5'
   ]
 },
 '157537' => {
   'Cowles' => [
     '1296',
     '1308'
   ]
 },
 '164438' => {
   'Cowles' => '2882'
 },
 '171436' => {
   'Cowles' => '3907.5'
 }
}

=== kLau field is properly processed
--- input
U+2145E	kLau	2945
U+2214F	kLau	1879 1880
U+20CD5	kLau	197
U+9F3B	kLau	85
---  expected
{
  '134357' => {
    'Lau' => '197'
  },
  '136286' => {
    'Lau' => '2945'
  },
  '139599' => {
    'Lau' => [
      '1879',
      '1880'
    ]
  },
  '40763' => {
    'Lau' => '85'
  }
}

=== kMeyerWempe field is properly processed
--- input
U+9F3E	kMeyerWempe	784
U+9F39	kMeyerWempe	889e
U+9F2B	kMeyerWempe	2666b
U+50E5	kMeyerWempe	736* 920d 1185a
---  expected
{
  '20709' => {
    'MeyerWempe' => [
      '736*',
      '920d',
      '1185a'
    ]
  },
  '40747' => {
    'MeyerWempe' => '2666b'
  },
  '40761' => {
    'MeyerWempe' => '889e'
  },
  '40766' => {
    'MeyerWempe' => '784'
  }
}

=== kNelson field is properly processed
--- input
U+5140	kNelson	0004
U+50E5	kNelson	0542
U+50F9	kNelson	0422 0548
U+515A	kNelson	1363
---  expected
{
  '20709' => {
    'Nelson' => '0542'
  },
  '20729' => {
    'Nelson' => [
      '0422',
      '0548'
    ]
  },
  '20800' => {
    'Nelson' => '0004'
  },
  '20826' => {
    'Nelson' => '1363'
  }
}
