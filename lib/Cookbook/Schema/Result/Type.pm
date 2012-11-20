use utf8;
package Cookbook::Schema::Result::Type;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Cookbook::Schema::Result::Type

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

=head1 TABLE: C<types>

=cut

__PACKAGE__->table("types");

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

=head1 PRIMARY KEY

=over 4

=item * L</type_id>

=back

=cut

__PACKAGE__->set_primary_key("type_id");

=head1 RELATIONS

=head2 recipes

Type: has_many

Related object: L<Cookbook::Schema::Result::Recipe>

=cut

__PACKAGE__->has_many(
  "recipes",
  "Cookbook::Schema::Result::Recipe",
  { "foreign.type_id" => "self.type_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-11-18 19:31:46
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:SGTawctVsGAWvdmMpKAfCg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
