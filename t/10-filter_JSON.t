use strict;
use warnings;
use Test::More;

use JSON;

BEGIN {
    $ENV{ANSI_COLORS_DISABLED} = 1;
    delete $ENV{DATAPRINTERRC};
    use File::HomeDir::Test;  # avoid user's .dataprinter
};

use Data::Printer {
    filters => {
       -external => [ 'JSON' ],
    },
};

my $json = <<EOD;
{
  "foo": false,
  "bar": false,
  "baz": true
}
EOD

foreach my $module (qw(JSON)) {

    SKIP: {
        eval "use $module";
        skip "$module not available", 1 if $@;

        my $data_structure = decode_json $json;
        my $dump = p $data_structure;
        my $named_dump = p $data_structure, JSON => { show_class_name => 1 };

        is( $dump, $module );
        is( $named_dump, "AIAIAIAIA ($module)", "$module with class name" );
    };
}

done_testing;
