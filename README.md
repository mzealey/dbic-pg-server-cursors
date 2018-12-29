When using Postgres with perl, DBI reads everything into memory, even if you
only want to use a DBIC cursor to itterate over it. This is obviously bad if
you have a large query.

With DBD::mysql you can truely itterate over the DBIC cursor by doing something like:

    $dbic->storage->dbh->{mysql_use_result} = 1;

However for DBD::Pg we don't have this option. The documentation recommends
using server-side cursors in this case, which is what this module implements.
You just need to use a custom Storage class for your connection (as shown in
the lib/Songs/ServerCursorSchema.pm example) and then whenever you do:

    $rs->next

the underlying cursor will fetch from the database 1000 rows at a time into
memory and itterate through them.

You probably want to create a custom connection for doing this as it requires a
bit more overhead than a simple select statement so you only want to use it on
queries that have the potential to return a large number of rows.

Note that `$rs->all` and equivelents still fetch everything into memory for
obvious reasons.
