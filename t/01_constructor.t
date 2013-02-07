use strict;
use warnings;
use Test::More;

use App::unzip932;

subtest 'constructor' => sub {
    my $app = App::unzip932->new;

    ok $app;
    isa_ok $app, "App::unzip932";
};

done_testing;
