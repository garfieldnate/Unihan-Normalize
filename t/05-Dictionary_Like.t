# check that readings are handled properly
# see http://www.unicode.org/reports/tr38/#N101BA
# includes:
# kCangjie
# kCheungBauer
# kCihaiT
# kFenn
# kFourCornerCode
# kFrequency
# kGradeLevel
# kHDZRadBreak
# kHKGlyph
# kPhonetic
# kTotalStrokes

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
=== kCangjie
--- input
U+3410	Cangjie	VEN
U+340C	Cangjie	OPD
--- expected
{
	'13324' => {
		'Cangjie' => 'OPD'
	},
	'13328' => {
		'Cangjie' => 'VEN'
	}
}
=== kCheungBauer
--- input
U+34BC	kCheungBauer	055/08;TLBO;mang4
U+35A3	kCheungBauer	030/08;;bu4
U+35C7	kCheungBauer	030/09;RRYE;gaa5,haa1
U+0000	kCheungBauer	000/00;;buh1 000/00;FAKE;fa1,ke2
--- expected
{
  '0' => {
    'CheungBauer' => [
      {
        'cangJie' => undef,
        'radical' => '000',
        'readings' => [
          'buh1'
        ],
        'stroke_count' => '00'
      },
      {
        'cangJie' => 'FAKE',
        'radical' => '000',
        'readings' => [
          'fa1',
          'ke2'
        ],
        'stroke_count' => '00'
      }
    ]
  },
  '13500' => {
    'CheungBauer' => [
      {
        'cangJie' => 'TLBO',
        'radical' => '055',
        'readings' => [
          'mang4'
        ],
        'stroke_count' => '08'
      }
    ]
  },
  '13731' => {
    'CheungBauer' => [
      {
        'cangJie' => undef,
        'radical' => '030',
        'readings' => [
          'bu4'
        ],
        'stroke_count' => '08'
      }
    ]
  },
  '13767' => {
    'CheungBauer' => [
      {
        'cangJie' => 'RRYE',
        'radical' => '030',
        'readings' => [
          'gaa5',
          'haa1'
        ],
        'stroke_count' => '09'
      }
    ]
  }
}
=== kCihaiT
--- input
U+35C9	kCihaiT	286.501
U+5145	kCihaiT	133.601 134.201
--- expected
{
  '13769' => {
    'CihaiT' => [
      '286.501'
    ]
  },
  '20805' => {
    'CihaiT' => [
      '133.601',
      '134.201'
    ]
  }
}
=== kFenn
--- SKIP
--- input
U+4E00  kFenn xyz
U+4E32  kFenn abc
--- expected
{
	'19968' => {
		'kFenn' => 'xyz'
	},
	'20018' => {
		'kFenn' => [
			'abc',
		]
	}
}
=== kFourCornerCode
--- SKIP
--- input
U+4E00  kFourCornerCode xyz
U+4E32  kFourCornerCode abc
--- expected
{
	'19968' => {
		'kFourCornerCode' => 'xyz'
	},
	'20018' => {
		'kFourCornerCode' => [
			'abc',
		]
	}
}
=== kFrequency
--- SKIP
--- input
U+4E00  kFrequency  xyz
U+4E32  kFrequency  abc
--- expected
{
	'19968' => {
		'kFrequency' => 'xyz'
	},
	'20018' => {
		'kFrequency' => [
			'abc',
		]
	}
}
=== kGradeLevel
--- SKIP
--- input
U+4E00  kGradeLevel xyz
U+4E32  kGradeLevel abc
--- expected
{
	'19968' => {
		'kGradeLevel' => 'xyz'
	},
	'20018' => {
		'kGradeLevel' => [
			'abc',
		]
	}
}
=== kHDZRadBreak
--- SKIP
--- input
U+4E00  kHDZRadBreak  xyz
U+4E32  kHDZRadBreak  abc
--- expected
{
	'19968' => {
		'kHDZRadBreak' => 'xyz'
	},
	'20018' => {
		'kHDZRadBreak' => [
			'abc',
		]
	}
}
=== kHKGlyph
--- SKIP
--- input
U+4E00  kHKGlyph  xyz
U+4E32  kHKGlyph  abc
--- expected
{
	'19968' => {
		'kHKGlyph' => 'xyz'
	},
	'20018' => {
		'kHKGlyph' => [
			'abc',
		]
	}
}
=== kPhonetic
--- SKIP
--- input
U+4E00  kPhonetic xyz
U+4E32  kPhonetic abc
--- expected
{
	'19968' => {
		'kPhonetic' => 'xyz'
	},
	'20018' => {
		'kPhonetic' => [
			'abc',
		]
	}
}
=== kTotalStrokes
--- SKIP
--- input
U+4E00  kTotalStrokes xyz
U+4E32  kTotalStrokes abc
--- expected
{
	'19968' => {
		'kTotalStrokes' => 'xyz'
	},
	'20018' => {
		'kTotalStrokes' => [
			'abc',
		]
	}
}

