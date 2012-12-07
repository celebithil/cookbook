use utf8;
package Cookbook::Schema::Result::Recipe;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Cookbook::Schema::Result::Recipe

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<recipes>

=cut

__PACKAGE__->table("recipes");

=head1 ACCESSORS

=head2 recipe_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 recipe_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 type_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 recipe

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "recipe_id",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "recipe_name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "type_id",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "recipe",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</recipe_id>

=back

=cut

__PACKAGE__->set_primary_key("recipe_id");

=head1 RELATIONS

=head2 type

Type: belongs_to

Related object: L<Cookbook::Schema::Result::Type>

=cut

__PACKAGE__->belongs_to(
  "type",
  "Cookbook::Schema::Result::Type",
  { type_id => "type_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-12-07 15:19:17
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:p0vF18cAvB5foB0A6P1JDA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
