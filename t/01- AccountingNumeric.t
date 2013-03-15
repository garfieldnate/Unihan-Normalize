# check that AccountNumeric field is handled properly
#todo: maybe test all numeric types in this file?


use t::TestConverter;
use Test::More 0.88;
plan tests => 1 * blocks();

# slurp each of the blocks into a unihan structure and check the output
for my $block (blocks()) {
	is_deeply($block->input, $block->expected)
		or note explain $block->input;
}

__DATA__
=== kAccountingNumeric field is properly processed
--- input slurp
U+4EDF	kAccountingNumeric	1000
U+4F0D	kAccountingNumeric	5
U+4F70	kAccountingNumeric	100
U+53C1	kAccountingNumeric	3
U+53C2	kAccountingNumeric	3
U+53C3	kAccountingNumeric	3
U+58F1	kAccountingNumeric	1
U+58F9	kAccountingNumeric	1
U+5F0C	kAccountingNumeric	1
U+5F0D	kAccountingNumeric	2
U+5F0E	kAccountingNumeric	3
---  expected eval
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
  '21442' => {
    'AccountingNumeric' => 3
  },
  '21443' => {
    'AccountingNumeric' => 3
  },
  '22769' => {
    'AccountingNumeric' => 1
  },
  '22777' => {
    'AccountingNumeric' => 1
  },
  '24332' => {
    'AccountingNumeric' => 1
  },
  '24333' => {
    'AccountingNumeric' => 2
  },
  '24334' => {
    'AccountingNumeric' => 3
  }
}