use strict;
use warnings;
use Test::More;

use App::unzip932;
use File::Temp ();
use Encode ();
use Capture::Tiny qw/capture/;
use utf8;

subtest 'Extract zip' => sub {
    my $zipfile = 't/test.zip';

    my $app = App::unzip932->new;
    $app->parse_options(qw/-t utf8 -l/, $zipfile);
    my ($stdout, $stderr) = capture {
        $app->run();
    };

    my $decoded = Encode::decode_utf8($stdout);

    like $decoded, qr/^テスト$/xms;
    like $decoded, qr/^サンプル$/xms;
    like $decoded, qr/^あいうえお$/xms;
};

done_testing;
