use strict;
use warnings;
use Test::More;


use Catalyst::Test 'cookbook';
use cookbook::Controller::recipe;

ok( request('/recipe')->is_success, 'Request should succeed' );
done_testing();
