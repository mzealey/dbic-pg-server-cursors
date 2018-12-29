use utf8;
package Songs::ServerCursorSchema;

use strict;
use warnings;

use lib '../Songs/lib';
use Songs::Schema;
use base 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces(
    result_namespace => '+Songs::Schema::Result',
);

sub connect {
    my $self = shift;
    $self->storage_type('::DBI::PgServerCursor');
    $self->SUPER::connect( @{Songs::Schema->conn_info} );
}

1;
