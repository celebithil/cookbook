use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Cookbook';
use Cookbook::Controller::Typec;

ok( request('/typec')->is_success, 'Request should succeed' );
done_testing();
