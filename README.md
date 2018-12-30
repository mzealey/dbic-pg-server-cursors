When using DBD::Pg everything is read into memory, even if you only want to use
a DBIC cursor to itterate over it. This is obviously bad if you have a large
query.

With DBD::mysql you can truely itterate over the DBIC cursor by doing something like:

    $dbic->storage->dbh->{mysql_use_result} = 1;

However for DBD::Pg we don't have this option. The documentation recommends
using server-side cursors in this case, which is what this module implements.
You just need to use a custom Storage class for your connection (as shown in
the lib/Songs/ServerCursorSchema.pm example) and then whenever you do:

    my $rs = $rs->search({}, { cursor_page_size => 1_000 });
    while( my $row = $rs->next ) { ... }

the underlying cursor will fetch from the database 1000 rows at a time into
memory and itterate through them.

If the `cursor_page_size` attribute is not specified then it will behave as
normal. You only want to use this on queries that have the potential to return
a large number of rows as it requires a bit more command overhead than a simple
select statement.

Note that `$rs->all` and equivelents still fetch everything into memory for
obvious reasons.
