#!perl
use strict;
use warnings;

use App::unzip932;

my $app = App::unzip932->new;
$app->parse_options(@ARGV);
$app->run;

__END__

=encoding utf-8

=for stopwords

=head1 NAME

unzip932 - unzip for CP932

=head1 SYNOPSIS

=head1 DESCRIPTION

Many people use unzip command for extracting ZIP archive. But unzip has
problem of encoding. unzip cannnot treat file name encoded CP932. If ZIP archive
contains such file, it happens character corruption.
So some Linux distributions, Ubuntu etc, patche unzip source code and resolve
this problem.

=head1 AUTHOR

Syohei YOSHIDA E<lt>syohex@gmail.comE<gt>

=head1 COPYRIGHT

Copyright 2013 - Syohei YOSHIDA

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
