#!C:\Perl\bin\perl.exe
use strict;
use warnings;
use Test::More;

use Catalyst::Test 'cookbook';

ok( request('/')->is_success, 'Request should succeed' );

done_testing();
