use inc::Module::Install;
use Module::Install::AuthorTests;
use Module::Install::Repository;

name 'App-unzip932';
all_from 'lib/App/unzip932.pm';

requires "Archive::Zip";
requires "Term::Encoding";
requires "Encode";

test_requires 'Test::More' => '0.98';

author_tests('xt');
auto_set_repository();
WriteAll;
