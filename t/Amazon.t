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
    is $amazon->add_cart('Perfect PHP', 3), 1, 'Perfect PHPを1個購入できること';
    
    throws_ok { $amazon->add_cart('Perfect Ruby', 3) } qr/no such item/, 'Perfect Rubyを購入しようとすると、買えないこと';
};

subtest 'ショッピングカート内の情報を見れる' => sub {
    my $amazon = Amazon->new();
    $amazon->add_cart('Perfect PHP', 1);
    
    is $amazon->get_cart, {name => 'Perfect PHP', num_purchases => 1}, 'カートの中身が見れること';
};


done_testing;
