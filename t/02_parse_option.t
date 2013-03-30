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

    my @argv = qw{-p -f utf-8 -t euc-jp -l -x excluded -d lib -q -o};
    $app->parse_options(@argv);

    my $options = $app->{options};
    ok $options->{pipe}, 'pipe option';
    is $options->{from}, 'utf-8', 'from option';
    is $options->{to}, 'euc-jp', 'to option';
    ok $options->{list}, 'print file list option';
    is_deeply $options->{excludes}, [qw/excluded/], "exclude option";
    is $options->{dest}, 'lib', 'dest option';
    ok $options->{overwrite}, 'overwrite option';
};

subtest 'long option' => sub {
    my $app = App::unzip932->new;

    my @argv = qw{
        --pipe --from=utf-8 --to=euc-jp --list
        --exclude=excluded --dest=lib --quite --overwrite
    };
    $app->parse_options(@argv);

    my $options = $app->{options};
    ok $options->{pipe}, 'pipe option';
    is $options->{from}, 'utf-8', 'from option';
    is $options->{to}, 'euc-jp', 'to option';
    ok $options->{list}, 'print file list option';
    is_deeply $options->{excludes}, [qw/excluded/], "exclude option";
    is $options->{dest}, 'lib', 'dest option';
    ok $options->{overwrite}, 'overwrite option';
};

subtest 'never(short)' => sub {
    my $app = App::unzip932->new;
    $app->parse_options(qw/-n/);

    my $options = $app->{options};
    ok $options->{never}, 'never option';
};

subtest 'never(long)' => sub {
    my $app = App::unzip932->new;
    $app->parse_options(qw/--never/);

    my $options = $app->{options};
    ok $options->{never}, 'never option';
};

done_testing;
