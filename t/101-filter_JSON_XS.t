use strict;
use Test::More;

BEGIN { require 't/base.include' }

SKIP: {

    eval { require JSON::XS };
    skip 'Needs JSON::XS', 1 if $@;
    use JSON::XS qw/decode_json/;
    my $dump = p decode_json input;
    is( $dump, expected, "JSON:XS, live" );
}

my $emulated = {
    alpha => \do { my $v = 1 },
    beta  => \do { my $v = 0 },
    gamma => 'V: $emulated->{alpha}',
    zeta  => 'V: $emulated->{beta}'
};
$emulated->{gamma} = $emulated->{alpha};
$emulated->{zeta}  = $emulated->{beta};
bless( $emulated->{alpha}, 'JSON::XS::Boolean' );
bless( $emulated->{beta},  'JSON::XS::Boolean' );
bless( $emulated->{gamma}, 'JSON::XS::Boolean' );
bless( $emulated->{zeta},  'JSON::XS::Boolean' );

is( p($emulated), expected, "JSON::XS, emulated" );

done_testing;
