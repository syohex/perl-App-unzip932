package App::unzip932;
use strict;
use warnings;

use 5.008_001;

use Archive::Zip;
use Carp ();
use Encode ();
use Term::Encoding ();
use Getopt::Long ();
use List::MoreUtils qw/any/;
use File::Temp ();

our $VERSION = '0.01';

sub new {
    my $class = shift;
    bless {}, $class;
}

sub parse_options {
    my ($self, @argv) = @_;

    local @ARGV = @argv;

    my %options;
    my @excludes;
    Getopt::Long::GetOptions(
        "p|pipe"        => \$options{pipe},
        "f|from=s"      => \$options{from},
        "l|list"        => \$options{list},
        "n|never"       => \$options{never},
        "x|exclude=s@"  => \@excludes,
        "d|dest=s"      => \$options{dest},
        "q|quite"       => \$options{quiet},
        "o|overwrite"   => \$options{overwrite},
    );

    $options{to} = Term::Encoding::term_encoding();

    _validate_options(\%options);

    if (@excludes) {
        $options{excludes} = [ map { Encode::decode($options{to}, $_) } @excludes ];
    }

    $self->{options} = \%options;
    $self->{zipfile} = shift @ARGV;
}

sub _validate_options {
    my $options = shift;

    if ($options->{never} && $options->{overwrite}) {
        Carp::carp("Both -o(never overwrite) and -o(overwrite) specified ignore '-o'");
        delete $options->{overwrite};
    }

    $options->{from} ||= 'cp932';
    unless (Encode::find_encoding($options->{from})) {
        Carp::croak("Encoding '$options->{from}' is not found");
    }

    unless (-d $options->{dest}) {
        Carp::croak("Destination '$options->{dest}' is not found");
    }
}

sub _check_zip_file {
    my $zipfile = shift;

    unless ($zipfile) {
        Carp::croak("Please specify ZIP archive file");
    }

    unless ($zipfile) {
        Carp::croak("$zipfile is not existed");
    }
}

sub run {
    my $self = shift;

    _check_zip_file($self->{zipfile});

    my $zip = Archive::Zip->new($self->{zipfile});
    my $tmp = File::Temp->new( UNLINK => 1 );

    my $options = $self->{options};
    for my $filename ( $zip->memberNames ) {
        my $output_name = Encode::decode($options->{from}, $filename);

        next if any { $output_name eq $_ } @{$options->{excludes}};

        if ($options->{list}) {
            print Encode::encode($options->{to}, $output_name), "\n";
            next;
        }

        if ($options->{pipe}) {
            $output_name = $tmp->filename;
        }

        $zip->extractMember($filename, $output_name);

        if ($options->{pipe}) {
            $tmp->autoflush(1);
            my $content = do {
                local $/;
                open my $fh, "<", $tmp->filename or die "Can't open file: $!";
                <$fh>;
            };

            print $content;
        }
    }
}

1;
__END__

=encoding utf-8

=for stopwords

=head1 NAME

App::unzip932 - unzip for CP932

=head1 SYNOPSIS

  use App::unzip932;

=head1 DESCRIPTION

App::unzip932 is

=head1 AUTHOR

Syohei YOSHIDA E<lt>syohex@gmail.comE<gt>

=head1 COPYRIGHT

Copyright 2013- Syohei YOSHIDA

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
