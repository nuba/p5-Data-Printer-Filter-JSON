use strict;
use Test::More;

BEGIN { require 't/base.include' }

SKIP: {

    eval { require JSON };
    skip 'Needs JSON', 1 if $@;
    use JSON qw/decode_json/;
    my $dump = p decode_json input;
    is( $dump, expected, "whatever's powering JSON, it works" );
}

done_testing;
