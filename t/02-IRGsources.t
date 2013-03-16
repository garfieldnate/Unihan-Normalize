# check IRG sources are handled properly
# This includes kIICore (pan-East Asia), kIRG_GSource (PRC and Singapore), kIRG_HSource (Hong Kong SAR), kIRG_JSource (Japan), kIRG_KPSource (North Korea), kIRG_KSource (South Korea), kIRG_MSource (Macao), kIRG_TSource (Taiwan), kIRG_USource (Unicode/USA), and kIRG_VSource (Vietnam).
# see http:http://www.unicode.org/reports/tr38/tr38-13.html#kIRG_GSource

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
=== kIICore field is properly processed
For now, you can only have 2.1. In the future, though, there will be more (3.0, etc.)
--- input
U+34E4	kIICore	2.1
U+3577	kIICore	2.1
U+0001	kIICore	3.0
---  expected
{
  '1' => {
    'IICore' => '3.0'
  },
  '13540' => {
    'IICore' => '2.1'
  },
  '13687' => {
    'IICore' => '2.1'
  }
}

=== kIRG_GSource field is properly processed
--- input
U+4E00	kIRG_GSource	G0-523B
U+4E82	kIRG_GSource	G1-4252
U+4EB6	kIRG_GSource	G3-3257
U+4ECC	kIRG_GSource	G5-313C
U+57AF	kIRG_GSource	G7-2121
U+3435	kIRG_GSource	GS-2269
U+4E26	kIRG_GSource	G8-2C76
U+9FB4	kIRG_GSource	G9-FE59
U+4E04	kIRG_GSource	GE-2121
U+2026F	kIRG_GSource	G4K
U+2054F	kIRG_GSource	GBK
U+20BDF	kIRG_GSource	GCH
U+213FA	kIRG_GSource	GCY
U+2A70A	kIRG_GSource	GCYY-00022
U+20270	kIRG_GSource	GFZ
U+2A85E	kIRG_GSource	GGH-2002.09
U+2ABC0	kIRG_GSource	GHC-1005.98
U+20273	kIRG_GSource	GHZ-10192.01
U+2B74B	kIRG_GSource	GIDC-701
U+2A70E	kIRG_GSource	GJZ-00002
U+2026D	kIRG_GSource	GKX-0109.14
U+2A7DD	kIRG_GSource	GXC-3001.22
U+2A7F2	kIRG_GSource	GZFY-00838
U+2B748	kIRG_GSource	GZH-0073.52
U+2A701	kIRG_GSource	GZJW-00001
---  expected
{
  '131693' => {
    'IRG_GSource' => 'GKX-0109.14'
  },
  '131695' => {
    'IRG_GSource' => 'G4K'
  },
  '131696' => {
    'IRG_GSource' => 'GFZ'
  },
  '131699' => {
    'IRG_GSource' => 'GHZ-10192.01'
  },
  '132431' => {
    'IRG_GSource' => 'GBK'
  },
  '13365' => {
    'IRG_GSource' => 'GS-2269'
  },
  '134111' => {
    'IRG_GSource' => 'GCH'
  },
  '136186' => {
    'IRG_GSource' => 'GCY'
  },
  '173825' => {
    'IRG_GSource' => 'GZJW-00001'
  },
  '173834' => {
    'IRG_GSource' => 'GCYY-00022'
  },
  '173838' => {
    'IRG_GSource' => 'GJZ-00002'
  },
  '174045' => {
    'IRG_GSource' => 'GXC-3001.22'
  },
  '174066' => {
    'IRG_GSource' => 'GZFY-00838'
  },
  '174174' => {
    'IRG_GSource' => 'GGH-2002.09'
  },
  '175040' => {
    'IRG_GSource' => 'GHC-1005.98'
  },
  '177992' => {
    'IRG_GSource' => 'GZH-0073.52'
  },
  '177995' => {
    'IRG_GSource' => 'GIDC-701'
  },
  '19968' => {
    'IRG_GSource' => 'G0-523B'
  },
  '19972' => {
    'IRG_GSource' => 'GE-2121'
  },
  '20006' => {
    'IRG_GSource' => 'G8-2C76'
  },
  '20098' => {
    'IRG_GSource' => 'G1-4252'
  },
  '20150' => {
    'IRG_GSource' => 'G3-3257'
  },
  '20172' => {
    'IRG_GSource' => 'G5-313C'
  },
  '22447' => {
    'IRG_GSource' => 'G7-2121'
  },
  '40884' => {
    'IRG_GSource' => 'G9-FE59'
  }
}

=== kIRG_HSource field is properly processed
--- input
U+9F69	kIRG_HSource	H-91C9
U+F907	kIRG_HSource	H3-8BF8
U+5159	kIRG_HSource	HB0-A259
U+9F66	kIRG_HSource	HB1-C569
U+9F65	kIRG_HSource	HB2-F6D3
---  expected
{
  '20825' => {
    'IRG_HSource' => 'HB0-A259'
  },
  '40805' => {
    'IRG_HSource' => 'HB2-F6D3'
  },
  '40806' => {
    'IRG_HSource' => 'HB1-C569'
  },
  '40809' => {
    'IRG_HSource' => 'H-91C9'
  },
  '63751' => {
    'IRG_HSource' => 'H3-8BF8'
  }
}

=== kIRG_JSource field is properly processed
--- input
U+96A0	kIRG_JSource	J0-3123
U+969F	kIRG_JSource	J1-6669
U+2123D	kIRG_JSource	J3-2F42
U+20B9F	kIRG_JSource	J3A-4F54
U+21255	kIRG_JSource	J4-245C
U+3400	kIRG_JSource	JA-2121
U+2B740	kIRG_JSource	JH-IB0607
U+2A708	kIRG_JSource	JK-65004
U+9FC4	kIRG_JSource	JARIB-754F

---  expected
{
  '13312' => {
    'IRG_JSource' => 'JA-2121'
  },
  '134047' => {
    'IRG_JSource' => 'J3A-4F54'
  },
  '135741' => {
    'IRG_JSource' => 'J3-2F42'
  },
  '135765' => {
    'IRG_JSource' => 'J4-245C'
  },
  '173832' => {
    'IRG_JSource' => 'JK-65004'
  },
  '177984' => {
    'IRG_JSource' => 'JH-IB0607'
  },
  '38559' => {
    'IRG_JSource' => 'J1-6669'
  },
  '38560' => {
    'IRG_JSource' => 'J0-3123'
  },
  '40900' => {
    'IRG_JSource' => 'JARIB-754F'
  }
}

=== kIRG_KPSource field is properly processed
--- input
U+3ED0	kIRG_KPSource	KP0-EAB2
U+3EDE	kIRG_KPSource	KP1-5952
---  expected
{
  '16080' => {
    'IRG_KPSource' => 'KP0-EAB2'
  },
  '16094' => {
    'IRG_KPSource' => 'KP1-5952'
  }
}

=== kIRG_KSource field is properly processed
--- input
U+2A77C	kIRG_MSource	MAC-00020
---  expected
{
  '173948' => {
    'IRG_MSource' => 'MAC-00020'
  },
}

=== kIRG_TSource field is properly processed
--- input
U+4E00	kIRG_TSource	T1-4421
U+4E07	kIRG_TSource	T2-2126
U+4E20	kIRG_TSource	T3-2262
U+4E23	kIRG_TSource	T4-2335
U+52B6	kIRG_TSource	T5-253A
U+5313	kIRG_TSource	T6-5074
U+5655	kIRG_TSource	T7-2163
U+2B74E	kIRG_TSource	TB-733E
U+9FC4	kIRG_TSource	TC-4A76
U+2A707	kIRG_TSource	TD-6735
U+2A726	kIRG_TSource	TE-3350
U+2F807	kIRG_TSource	TF-2D68
---  expected
{
  '173831' => {
    'IRG_TSource' => 'TD-6735'
  },
  '173862' => {
    'IRG_TSource' => 'TE-3350'
  },
  '177998' => {
    'IRG_TSource' => 'TB-733E'
  },
  '194567' => {
    'IRG_TSource' => 'TF-2D68'
  },
  '19968' => {
    'IRG_TSource' => 'T1-4421'
  },
  '19975' => {
    'IRG_TSource' => 'T2-2126'
  },
  '20000' => {
    'IRG_TSource' => 'T3-2262'
  },
  '20003' => {
    'IRG_TSource' => 'T4-2335'
  },
  '21174' => {
    'IRG_TSource' => 'T5-253A'
  },
  '21267' => {
    'IRG_TSource' => 'T6-5074'
  },
  '22101' => {
    'IRG_TSource' => 'T7-2163'
  },
  '40900' => {
    'IRG_TSource' => 'TC-4A76'
  }
}

=== kIRG_USource field is properly processed
--- input
U+2B81A	kIRG_USource	UTC-00859
U+2F89F	kIRG_USource	UCI-00944
---  expected
{
  '178202' => {
    'IRG_USource' => 'UTC-00859'
  },
  '194719' => {
    'IRG_USource' => 'UCI-00944'
  }
}

=== kIRG_VSource field is properly processed
--- input
U+346B	kIRG_VSource	V0-3034
U+4E00	kIRG_VSource	V1-4A21
U+4E9E	kIRG_VSource	V2-8A2C
U+5056	kIRG_VSource	V3-3024
U+28599	kIRG_VSource	V4-5565
---  expected
 {
   '13419' => {
     'IRG_VSource' => 'V0-3034'
   },
   '165273' => {
     'IRG_VSource' => 'V4-5565'
   },
   '19968' => {
     'IRG_VSource' => 'V1-4A21'
   },
   '20126' => {
     'IRG_VSource' => 'V2-8A2C'
   },
   '20566' => {
     'IRG_VSource' => 'V3-3024'
   }
 }
