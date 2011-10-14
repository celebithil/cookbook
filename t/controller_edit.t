use strict;
use warnings;
use Test::More;


use Catalyst::Test 'cookbook';
use cookbook::Controller::edit;

ok( request('/edit')->is_success, 'Request should succeed' );
done_testing();
