use strict;
use warnings;
use Test::More;


use Catalyst::Test 'cookbook';
use cookbook::Controller::view;

ok( request('/view')->is_success, 'Request should succeed' );
done_testing();
