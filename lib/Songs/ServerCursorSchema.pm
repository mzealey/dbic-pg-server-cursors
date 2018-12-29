use utf8;
package Songs::ServerCursorSchema;

use strict;
use warnings;

use lib '../Songs/lib';
use Songs::Schema;
use base 'DBIx::Class::Schema';

sub connect {
    my $self = shift;
    $self->storage_type('::DBI::PgServerCursor');
    $self->SUPER::connect( @{Songs::Schema->conn_info} );
}

1;
