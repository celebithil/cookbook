use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Cookbook';
use Cookbook::Controller::type;

ok( request('/type')->is_success, 'Request should succeed' );
done_testing();
