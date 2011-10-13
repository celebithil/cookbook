package cookbook::Schema::cookbookdb::Result::Dish;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

cookbook::Schema::cookbookdb::Result::Dish

=cut

__PACKAGE__->table("dish");

=head1 ACCESSORS

=head2 dish_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 dish_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 type_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 receipt

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "dish_id",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "dish_name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "type_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 0 },
  "receipt",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("dish_id");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-09-29 17:45:32
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KIV22HS/Kk4WMliD8Gvvng


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
