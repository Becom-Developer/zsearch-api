package Zsearch::SearchSQL;
use parent 'Zsearch';
use strict;
use warnings;
use utf8;

sub run {
    my ( $self, @args ) = @_;
    my $options = shift @args;
    return $self->error->commit("No arguments") if !$options;
    return $self->_like($options)               if $options->{method} eq 'like';
    return $self->error->commit(
        "Method not specified correctly: $options->{method}");
}

sub _like {
    my ( $self, @args ) = @_;
    my $options  = shift @args;
    my $params   = $options->{params};
    my $q_params = +{};
    my $cols     = [];
    for my $key ( 'zipcode', 'pref', 'city', 'town' ) {
        next if !exists $params->{$key};
        $q_params->{$key} = $params->{$key};
        if ( $params->{$key} ne '' ) {
            push @{$cols}, $key;
        }
    }
    return $self->error->commit("Zipcode not specified correctly:")
      if !@{$cols};
    my $rows = $self->valid_search( 'post', $q_params, { cond => 'LIKE%' } );
    if ( !$rows ) {
        $rows = [];
    }
    my $count  = @{$rows};
    my $output = +{
        message => "検索件数: $count",
        data    => $rows,
        version => $self->zipcode_version(),
        count   => $count,
    };
    return $output;
}

1;
