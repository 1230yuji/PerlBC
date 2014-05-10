#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Test::Exception;

subtest 'モジュールが読み込める' => sub {
    use_ok 'Amazon';
}

subtest 'モジュールが使えること' => sub {
    my $amazon = Amazon->use();
    isa_ok $amazon;
}

done_testing;
