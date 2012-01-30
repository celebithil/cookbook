package Cookbook::Schema::Result::Dish;

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

Cookbook::Schema::Result::Dish

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
  is_foreign_key: 1
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
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "receipt",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("dish_id");

=head1 RELATIONS

=head2 type

Type: belongs_to

Related object: L<Cookbook::Schema::Result::Type>

=cut

__PACKAGE__->belongs_to(
  "type",
  "Cookbook::Schema::Result::Type",
  { type_id => "type_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-10-18 00:03:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LlPrDrsUTJcCWzm+84KFLw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
