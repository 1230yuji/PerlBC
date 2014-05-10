package Amazon;

use strict;
use warnings;
use Data::Dumper;

sub new {
    my ( $class ) = @_;

    #warn Dumper ITEMS;

    bless{
        cart => {},
        items => {name => 'Perfect PHP',  price => 3600 , release => '2010/11', stock => 2 }
    }, $class;
}

sub add_cart {
    my ($self, $name , $num_purchases) = @_;
    #warn Dumper $self->{items};
    for my $item ($self->{items}) {
        #warn Dumper $item;
        if($self->{items}{name} eq $name) {
            #一致していたらカートに入れる
            $self->{cart}->{$item->{name}} = $item;

            return 1;
        }else {
            die 'no such item';
        }
    }
}

1;
