requires 'Archive::Zip';
requires 'Term::Encoding';
requires 'List::MoreUtils';
requires 'IO::Prompt::Simple';

on test => sub {
    requires 'Test::More', '0.98';
    requires 'Capture::Tiny', '0',
};

on configure => sub  {
    requires 'Module::Build::Pluggable';
    requires 'Module::Build::Pluggable::GithubMeta';
    requires 'Module::Build::Pluggable::CPANfile';
};
