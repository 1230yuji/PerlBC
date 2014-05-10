package Amazon;

use strict;
use warnings;
use Data::Dumper;

sub new {
    my ( $class ) = @_;

    bless{
        cart => {},
        items => {
            'Perfect PHP' => {
                name    => 'Perfect PHP',
                price   => 3600 ,
                release => '2010/11',
                stock   => 2,
            }
        },
        deliveries => {
            '通常配達'     => 0,
            '当日お急ぎ便' => 200,
        },
        payments => {
            'クレジットカード'  => 1,
            '代金引換'          => 1,
            'コンビニ・ATM払い' => 1,
        },
    }, $class;
}

sub add_cart {
    my ($self, $name , $num_purchases) = @_;
    for my $item_name (keys $self->{items}) {
        if($item_name eq $name) {

            #在庫が購入数より少ない場合
            if($self->{items}{$item_name}{stock} < $num_purchases) {
                die '在庫が足りません';
            }

            #一致していたらカートに入れる
            $self->{cart}{$item_name} = {
                name => $name,
                price => $self->{items}{$item_name}{price},
                release => $self->{items}{$item_name}{release},
                num_purchases => $num_purchases
            };
               
            #在庫を減らす
            $self->{items}{$item_name}{stock} -= $num_purchases;
 
            return 1;
        }else {
            die 'no such item';
        }
    }
}

sub get_cart {
    my ( $self ) = shift;
    return $self->{cart};
}

sub payoff {
    my ($self, $delivery , $payment) = @_;
    my $amount = 0;
    if (defined $self->{deliveries}{$delivery}) {
        $amount += $self->{deliveries}{$delivery};
    }
    else {
        die '配送方法が正しくありません。';
    }
    die '支払い方法が正しくありません。' unless defined $self->{payments}{$payment};
    
    for my $item_name ( keys $self->{cart} ) {
        $amount += $self->{cart}{$item_name}{price} * $self->{cart}{$item_name}{num_purchases};
    }
    return $amount;
}

sub add_item {
    my($self, $add_name, $add_price, $add_release, $add_stock) = @_;

    $self->{items}{$add_name} = {
        name => $add_name,
        price => $add_price,
        release => $add_release,
        stock => $add_stock
    };

    warn Dumper $self->{items};

    return 1;
}
1;
