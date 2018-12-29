#!/usr/bin/perl
# Execute with DBIC_TRACE=1 to see the new queries being issued
use v5.16;
use FindBin::libs;
use strictures;

use lib '../Songs/lib';
use Songs::Schema;
my $dbic = Songs::Schema->connect;
my $rs = $dbic->resultset('Song');
my $count = 0;
while( my $row = $rs->next ) {
    $count++;
    last if $count > 2500;
}
$rs->reset;
while( my $row = $rs->next ) {
    $count++;
}
say $count;
