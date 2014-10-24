#! perl
use warnings;
use strict;

# $Id: 1basic.t 5 2008-03-09 03:15:13Z abeltje $
use Test::More tests => 8;

{
    my $nowstamp = time;
    my $fixstamp;
    {
        use fixedtime epoch_offset => 1204286400; # 29 Feb 2008 12:00:00 GMT

        ok defined \&CORE::GLOBAL::time,   "CORE::GLOBAL::time() defined";
        ok defined \&CORE::GLOBAL::gmtime, "CORE::GLOBAL::gmtime() defined";
        ok defined \&CORE::GLOBAL::localtime,
           "CORE::GLOBAL::localtime() defined";

        $fixstamp = time;
        is $fixstamp, 1204286400, "Fixed point in time ($fixstamp)";

        no fixedtime;
        is time, $nowstamp, "we ran fast enough inner ($nowstamp)";
        isnt $nowstamp, $fixstamp, "now() != fixed";
    }

    is time, $nowstamp, "we ran fast enough outer ($nowstamp)";
    isnt $nowstamp, $fixstamp, "now() != fixed";
}
