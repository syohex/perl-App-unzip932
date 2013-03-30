requires 'Archive::Zip';
requires 'Term::Encoding';
requires 'List::MoreUtils';

on test => sub {
    requires 'Test::More', '0.98';
    requires 'Capture::Tiny', '0',
};

on configure => sub  {
    requires 'Module::Build', '0.38',
};

on build => sub  {
    requires 'Module::Build', '0.38',
};
