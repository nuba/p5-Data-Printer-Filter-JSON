use strict;
use Test::More;

BEGIN { require 't/base.include' }

SKIP: {
    eval { 
        require JSON::JOM;
        JSON::JOM->import(qw/from_json/);
    };
    skip 'Needs JSON::JOM', 1 if $@;

    my $input = '{"alpha":true,"beta":false,"gamma":true,"zeta":false,"zu":[1,2,3,4],"zuu":{"zuua":"zuua","zuub":"zuub"}}';
    my $expected = '\ \ {
    alpha   \ true,
    beta    \ false,
    gamma   \ true,
    zeta    \ false,
    zu      \ \ [
        [0] \ 1,
        [1] \ 2,
        [2] \ 3,
        [3] \ 4
    ],
    zuu     \ \ {
        zuua   \ "zuua",
        zuub   \ "zuub"
    }
}';
    is( p( from_json( $input ) ), $expected, "JSON:JOM, from_json, live" );
}

done_testing;
