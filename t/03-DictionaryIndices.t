# check that dictionary indices are handled properly
# see http://www.unicode.org/reports/tr38/tr38-13.html#N1013C
# includes: 
# official IRG indices: kIRGHanyuDaZidian kIRGKangXi kIRGDaeJaweon kIRGDaiKanwaZiten
# general purpose Chinese: kCihaiT kFennIndex kGSR kKarlgren kMatthews kSBGY
# Cantonese: kCheungBauerIndex kCowles kLau kMeyerWemp
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
