#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Test::Exception;

subtest '$B%b%8%e!<%k$,FI$_9~$a$k(B' => sub {
    use_ok 'Amazon';
}

subtest '$B%b%8%e!<%k$,;H$($k$3$H(B' => sub {
    my $amazon = Amazon->use();
    isa_ok $amazon;
}

done_testing;
