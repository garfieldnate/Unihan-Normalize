# check that readings are handled properly
# see http://www.unicode.org/reports/tr38/tr38-13.html#N109C
# includes: 
# kCantonese, kDefinition, kHangul, kHanyuPinlu, 
# kHanyuPinyin, kJapaneseKun, kJapaneseOn, kKorean, 
# kMandarin, kTang, kVietnamese, kXHC1983

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
=== kCantonese
--- input
U+3400	kCantonese	jau1
U+342B	kCantonese	gun3 hung1 zung1
---  expected
{
  '13312' => {
    'Cantonese' => 'jau1'
  },
  '13355' => {
    'Cantonese' => [
      'gun3',
      'hung1',
      'zung1'
    ]
  }
}

=== kDefinition
--- input
U+3400	kDefinition	(same as U+4E18 丘) hillock or mound
--- expected
{
  '13312' => {
    'Definition' => '(same as U+4E18 丘) hillock or mound'
  },
}

=== kHangul
--- input
U+4E00	kHangul	일
U+4E32	kHangul	곶 관
--- expected
{
  '19968' => {
    'Hangul' => '일'
  },
  '20018' => {
    'Hangul' => [
      '곶',
      '관'
    ]
  }
}

=== kHanyuPinlu
--- input
U+4E38	kHanyuPinlu	wan2(13)
U+4E39	kHanyuPinlu	dan1(31) dan5(11)
--- expected
{
  '20024' => {
    'HanyuPinlu' => 'wan2(13)'
  },
  '20025' => {
    'HanyuPinlu' => [
      'dan1(31)',
      'dan5(11)'
    ]
  }
}
=== kHanyuPinyin
--- input
U+34CE	kHanyuPinyin	10297.260:qīn,qìn,qǐn
U+34D8	kHanyuPinyin	10278.080,10278.090:sù
U+5364	kHanyuPinyin	10093.130:xī,lǔ 74609.020:lǔ,xī
U+5EFE	kHanyuPinyin	10513.110,10514.010,10514.020:gǒng
--- expected
{
  '13518' => {
    'HanyuPinyin' => {
      '10297.260' => [
        'qīn',
        'qìn',
        'qǐn'
      ]
    }
  },
  '13528' => {
    'HanyuPinyin' => {
      '10278.080,10278.090' => [
        'sù'
      ]
    }
  },
  '21348' => {
    'HanyuPinyin' => [
      {
        '10093.130' => [
          'xī',
          'lǔ'
        ]
      },
      {
        '74609.020' => [
          'lǔ',
          'xī'
        ]
      }
    ]
  },
  '24318' => {
    'HanyuPinyin' => {
      '10513.110,10514.010,10514.020' => [
        'gǒng'
      ]
    }
  }
}
