package Data::Printer::Filter::JSON;

use 5.006;
use strict;
use warnings;

use Data::Printer::Filter;
use Term::ANSIColor;

=head1 NAME

Data::Printer::Filter::JSON - The great new Data::Printer::Filter::JSON!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

our $show_repeated = {
  'JSON::XS::Boolean' => 1, # true
  'JSON::PP::Boolean' => 'lalala', # also true
};

filter "$_" => sub {
    my ($obj, $p) = @_;
    my $str = $$obj == 1 ? 'true' : 'false';

    my %defaults = (
      true => 'black on_bright_blue',
      false => 'white on_blue'
    );

    my $color = $p->{JSON}{boolean}{$str};
    $color = $defaults{$str} unless defined $color;
    return colored($str, $color);
} for qw/JSON::XS::Boolean JSON::PP::Boolean/;

1; # End of Data::Printer::Filter::JSON
