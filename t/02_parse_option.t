use strict;
use warnings;
use Test::More;

use App::unzip932;

subtest 'can_ok' => sub {
    my $app = App::unzip932->new;
    can_ok $app, 'parse_options';
};

subtest 'short option' => sub {
    my $app = App::unzip932->new;

    my @argv = qw{-p -f utf-8 -l -x excluded -d lib -q -o};
    $app->parse_options(@argv);

    my $options = $app->{options};
    ok $options->{pipe};
    is $options->{from}, 'utf-8';
    ok $options->{list};
    is_deeply $options->{excludes}, [qw/excluded/];
    is $options->{dest}, 'lib';
    ok $options->{overwrite};
};

done_testing;
