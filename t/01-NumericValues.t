# check that numeric value fields are handled properly
# This includes kPrimaryNumeric, kAccountingNumeric, and kOtherNumeric 
# see http://www.unicode.org/reports/tr38/tr38-13.html#N1024D

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
=== kAccountingNumeric field is properly processed
--- input
U+4EDF	kAccountingNumeric	1000
U+4F0D	kAccountingNumeric	5
U+4F70	kAccountingNumeric	100
U+53C1	kAccountingNumeric	3
U+5146	kPrimaryNumeric	1000000000000
---  expected
{
  '20191' => {
    'AccountingNumeric' => 1000
  },
  '20237' => {
    'AccountingNumeric' => 5
  },
  '20336' => {
    'AccountingNumeric' => 100
  },
  '21441' => {
    'AccountingNumeric' => 3
  },
   '20806' => {
     'PrimaryNumeric' => 1000000000000
   }
}

=== kPrimaryNumeric field is properly processed
--- input
U+516B	kPrimaryNumeric	8
U+5341	kPrimaryNumeric	10
U+5343	kPrimaryNumeric	1000
U+56DB	kPrimaryNumeric	4
U+767E	kPrimaryNumeric	100
---  expected
{
  '20843' => {
    'PrimaryNumeric' => 8
  },
  '21313' => {
    'PrimaryNumeric' => 10
  },
  '21315' => {
    'PrimaryNumeric' => 1000
  },
  '22235' => {
    'PrimaryNumeric' => 4
  },
  '30334' => {
    'PrimaryNumeric' => 100
  }
}

=== kOtherNumeric field is properly processed
--- input
U+20001	kOtherNumeric	7
U+20983	kOtherNumeric	30
U+2098C	kOtherNumeric	40
---  expected
{
  '131073' => {
    'OtherNumeric' => 7
  },
  '133507' => {
    'OtherNumeric' => 30
  },
  '133516' => {
    'OtherNumeric' => 40
  },
}

=== All numeric fields work together
--- input
U+3405	kOtherNumeric	5
U+3483	kOtherNumeric	2
U+4E03	kPrimaryNumeric	7
U+4E07	kPrimaryNumeric	10000
U+4EC0	kOtherNumeric	10
U+4EDF	kAccountingNumeric	1000
U+4EE8	kOtherNumeric	3
U+4F0D	kAccountingNumeric	5
U+4F70	kAccountingNumeric	100
U+5146	kPrimaryNumeric	1000000000000
---  expected
 {
   '13317' => {
     'OtherNumeric' => 5
   },
   '13443' => {
     'OtherNumeric' => 2
   },
   '19971' => {
     'PrimaryNumeric' => 7
   },
   '19975' => {
     'PrimaryNumeric' => 10000
   },
   '20160' => {
     'OtherNumeric' => 10
   },
   '20191' => {
     'AccountingNumeric' => 1000
   },
   '20200' => {
     'OtherNumeric' => 3
   },
   '20237' => {
     'AccountingNumeric' => 5
   },
   '20336' => {
     'AccountingNumeric' => 100
   },
   '20806' => {
     'PrimaryNumeric' => 1000000000000
   }
 }