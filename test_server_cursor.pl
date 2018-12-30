#!/usr/bin/perl
# Execute with DBIC_TRACE=1 to see the new queries being issued
use v5.16;
use FindBin::libs;
use strictures;

use Songs::ServerCursorSchema;
my $dbic = Songs::ServerCursorSchema->connect;
my $rs_no_cursor = $dbic->resultset('Song')->search({}, { rows => 2000 });
my $count = 0;
while( my $row = $rs_no_cursor->next ) {
    $count++;
    last if $count > 2500;
}

my $rs = $dbic->resultset('Song')->search({}, { cursor_page_size => 500 });
$count = 0;
while( my $row = $rs->next ) {
    $count++;
    last if $count > 2500;
}
$rs->reset;
$count = 0;
while( my $row = $rs->next ) {
    $count++;
}
say $count;
