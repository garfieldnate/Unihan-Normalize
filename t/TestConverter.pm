package t::TestConverter;
use Test::Base -Base;


package t::TestConverter::Filter;
use Test::Base::Filter -base;
use Unihan::Normalize::Slurp qw(slurp_fh);
use autodie;

sub slurp {
	my ($input) = shift;
	open my $input_fh, '<', \$input;
	
	return slurp_fh($input_fh);
}