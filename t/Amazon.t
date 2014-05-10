#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Test::Exception;

subtest 'モジュールが読み込める' => sub {
    use_ok 'Amazon';
};

subtest 'モジュールが使えること' => sub {
    my $amazon = Amazon->new();
    isa_ok $amazon, 'Amazon';
    can_ok $amazon, qw(new add_cart);
};

subtest 'ショッピングカートに追加できる' => sub {
    my $amazon = Amazon->new();
    is $amazon->add_cart('Perfect PHP', 1), 1, 'Perfect PHPを1個購入できること';
};

done_testing;
