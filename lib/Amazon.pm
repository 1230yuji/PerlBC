﻿package Amazon;

use strict;
use warnings;
use Data::Dumper;

sub new {
    my ( $class ) = @_;

    bless{
        cart => {},
        items => {'Perfect PHP' => {name => 'Perfect PHP',  price => 3600 , release => '2010/11', stock => 2 }}
    }, $class;
}

sub add_cart {
    my ($self, $name , $num_purchases) = @_;
    for my $item_name (keys $self->{items}) {
        if($item_name eq $name) {
            #一致していたらカートに入れる
            $self->{cart}->{$item_name} = {name => $name, num_purchases => $num_purchases};
               
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

1;
