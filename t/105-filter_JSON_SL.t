use strict;
use Test::More;

BEGIN { require 't/base.include' }

SKIP: {

    eval { require JSON::SL };
    skip 'Needs JSON::SL', 1 if $@;
    use JSON::SL qw/decode_json/;
    my $dump = p decode_json input;
    is( $dump, expected, "JSON:SL, live" );
}

my $emulated = {
          'gamma' => bless( do{\(my $o = 1)}, 'JSON::SL::Boolean' ),
          'alpha' => bless( do{\(my $o = 1)}, 'JSON::SL::Boolean' ),
          'zeta' => bless( do{\(my $o = 0)}, 'JSON::SL::Boolean' ),
          'beta' => bless( do{\(my $o = 0)}, 'JSON::SL::Boolean' )

};

is( p($emulated), expected, "JSON::SL, emulated" );

done_testing;
