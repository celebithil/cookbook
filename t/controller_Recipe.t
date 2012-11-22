use strict;
use warnings;
use Test::More;


use Catalyst::Test 'cookbook';
use cookbook::Controller::Recipe;

ok( request('/recipe')->is_success, 'Request should succeed' );
ok( request('/recipe/view')->is_success, 'Request should succeed' );
ok( request('/recipe/edit')->is_success, 'Request should succeed' );
ok( request('/recipe/add')->is_success, 'Request should succeed' );
ok( request('/recipe/insert')->is_success, 'Request should succeed' );
done_testing();
