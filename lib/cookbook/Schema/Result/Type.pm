package Cookbook::Schema::Result::Type;

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

Cookbook::Schema::Result::Type

=cut

__PACKAGE__->table("type");

=head1 ACCESSORS

=head2 type_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 type_name

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=cut

__PACKAGE__->add_columns(
  "type_id",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "type_name",
  { data_type => "varchar", is_nullable => 1, size => 50 },
);
__PACKAGE__->set_primary_key("type_id");

=head1 RELATIONS

=head2 dishes

Type: has_many

Related object: L<Cookbook::Schema::Result::Dish>

=cut

__PACKAGE__->has_many(
  "dishes",
  "Cookbook::Schema::Result::Dish",
  { "foreign.type_id" => "self.type_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-10-18 00:03:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/irZsOl1qE4uXyGVj5DZzA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
