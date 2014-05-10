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
    can_ok $amazon, qw(new add_cart get_cart);
};

subtest 'ショッピングカートに追加できる' => sub {
    my $amazon = Amazon->new();
    is $amazon->add_cart('Perfect PHP', 1), 1, 'Perfect PHPを1個購入できること';

    is $amazon->{items}{'Perfect PHP'}{stock} , 1, 'Perfect PHP の在庫が減っていること';

    throws_ok { $amazon->add_cart('Perfect PHP', 3) } qr/在庫が足りません/, '在庫分以上を買おうとすると、買えないこと';

    
    throws_ok { $amazon->add_cart('Perfect Ruby', 3) } qr/no such item/, 'Perfect Rubyを購入しようとすると、買えないこと';
};

subtest 'ショッピングカート内の情報を見れる' => sub {
    my $amazon = Amazon->new();
    $amazon->add_cart('Perfect PHP', 1);
    is_deeply $amazon->get_cart,
    { 'Perfect PHP' => {
            name => 'Perfect PHP',
            price => 3600,
            release => '2010/11',
            num_purchases => 1
        }
    },
    'カートの中身が見れること';
};

subtest '精算する' => sub {
    my $amazon = Amazon->new();
    $amazon->add_cart('Perfect PHP', 1);

    is $amazon->payoff('当日お急ぎ便', 'クレジットカード'), 3800, 'Perfect PHPを1個、通常配送、クレジット支払いでの合計金額を算出できること';

    throws_ok { $amazon->payoff('明日お急ぎ便', 'クレジットカード') } qr/配送方法が正しくありません。/, '正しくない配送方法を入力すると、精算できないこと';

    throws_ok { $amazon->payoff('通常配達', '出世払い') } qr/支払い方法が正しくありません。/, '正しくない支払い方法を入力すると、精算できないこと'
};

subtest '新たな商品の追加' => sub {
    my $amazon = Amazon->new ();
    is $amazon->add_item('TEST-DRIVEN DEVELOPMENT', 3000, '2006/12', 0), 1, '商品の追加ができること';
};

done_testing;
