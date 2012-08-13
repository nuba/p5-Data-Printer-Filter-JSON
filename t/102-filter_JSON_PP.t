use strict;
use Test::More;

BEGIN { require 't/base.include' }

SKIP: {

    eval { require JSON::PP };
    skip 'Needs JSON::PP', 1 if $@;
    use JSON::PP;
    my $dump = p(JSON::PP->new->decode(input));
    is( $dump, expected, "JSON::PP, live" );
}

my $emulated = {
    alpha => \do { my $v = 1 },
    beta  => \do { my $v = 0 },
    gamma => 'V: $emulated->{alpha}',
    zeta  => 'V: $emulated->{beta}'
};
$emulated->{gamma} = $emulated->{alpha};
$emulated->{zeta}  = $emulated->{beta};
bless( $emulated->{alpha}, 'JSON::PP::Boolean' );
bless( $emulated->{beta},  'JSON::PP::Boolean' );
bless( $emulated->{gamma}, 'JSON::PP::Boolean' );
bless( $emulated->{zeta},  'JSON::PP::Boolean' );

is( p($emulated), expected, "JSON::PP, emulated" );

done_testing;
