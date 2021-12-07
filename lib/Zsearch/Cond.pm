package Zsearch::Cond;
use parent 'Zsearch';
use Zsearch::Format;
use strict;
use warnings;
use utf8;
sub format { return Zsearch::Format->new; }

sub refined_search {
    my ( $self, $cond, $row, $type ) = @_;
    my $code = $cond->{code};
    my $pref = $cond->{pref};
    my $city = $cond->{city};
    my $town = $cond->{town};
    my ( $has_code, $has_pref, $has_city, $has_town ) = 0;
    if ( ( $code ne '' ) && ( defined $code ) ) {
        $has_code = 1;
    }
    if ( ( $pref ne '' ) && ( defined $pref ) ) {
        $has_pref = 1;
    }
    if ( ( $city ne '' ) && ( defined $city ) ) {
        $has_city = 1;
    }
    if ( ( $town ne '' ) && ( defined $town ) ) {
        $has_town = 1;
    }
    my ( $r_code, $r_pref, $r_city, $r_town );
    if ( $type && ( $type eq 'json' ) ) {
        $r_code = $row->{zipcode};
        $r_pref = $row->{pref};
        $r_city = $row->{city};
        $r_town = $row->{town};
    }
    else {
        $r_code = $row->[2];
        $r_pref = $row->[6];
        $r_city = $row->[7];
        $r_town = $row->[8];
    }
    if ( $has_code && $has_pref && $has_city && $has_town ) {
        return if $r_code !~ /^$code/;
        return if $r_pref !~ /^$pref/;
        return if $r_city !~ /^$city/;
        return if $r_town !~ /^$town/;
        return $self->format->zipcode( $row, $type );
    }
    if ( $has_code && $has_pref && $has_city ) {
        return if $r_code !~ /^$code/;
        return if $r_pref !~ /^$pref/;
        return if $r_city !~ /^$city/;
        return $self->format->zipcode( $row, $type );
    }
    if ( $has_code && $has_pref && $has_town ) {
        return if $r_code !~ /^$code/;
        return if $r_pref !~ /^$pref/;
        return if $r_town !~ /^$town/;
        return $self->format->zipcode( $row, $type );
    }
    if ( $has_code && $has_city && $has_town ) {
        return if $r_code !~ /^$code/;
        return if $r_city !~ /^$city/;
        return if $r_town !~ /^$town/;
        return $self->format->zipcode( $row, $type );
    }
    if ( $has_pref && $has_city && $has_town ) {
        return if $r_pref !~ /^$pref/;
        return if $r_city !~ /^$city/;
        return if $r_town !~ /^$town/;
        return $self->format->zipcode( $row, $type );
    }
    if ( $has_city && $has_town ) {
        return if $r_city !~ /^$city/;
        return if $r_town !~ /^$town/;
        return $self->format->zipcode( $row, $type );
    }
    if ( $has_pref && $has_town ) {
        return if $r_pref !~ /^$pref/;
        return if $r_town !~ /^$town/;
        return $self->format->zipcode( $row, $type );
    }
    if ( $has_pref && $has_city ) {
        return if $r_pref !~ /^$pref/;
        return if $r_city !~ /^$city/;
        return $self->format->zipcode( $row, $type );
    }
    if ( $has_code && $has_town ) {
        return if $r_code !~ /^$code/;
        return if $r_town !~ /^$town/;
        return $self->format->zipcode( $row, $type );
    }
    if ( $has_code && $has_city ) {
        return if $r_code !~ /^$code/;
        return if $r_city !~ /^$city/;
        return $self->format->zipcode( $row, $type );
    }
    if ( $has_code && $has_pref ) {
        return if $r_code !~ /^$code/;
        return if $r_pref !~ /^$pref/;
        return $self->format->zipcode( $row, $type );
    }
    return $self->format->zipcode( $row, $type )
      if $has_code && ( $r_code =~ /^$code/ );
    return $self->format->zipcode( $row, $type )
      if $has_pref && ( $r_pref =~ /^$pref/ );
    return $self->format->zipcode( $row, $type )
      if $has_city && ( $r_city =~ /^$city/ );
    return $self->format->zipcode( $row, $type )
      if $has_town && ( $r_town =~ /^$town/ );
    return;
}

1;

__END__

条件まとめ
code, pref, city, town
code, pref, city
code, pref,       town
code,       city, town
      pref, city, town
            city, town
      pref,       town
      pref, city
code,             town
code,       city
code, pref
code,
      pref
            city
                  town

code 必須
code, pref, city, town
code, pref, city
code, pref,       town
code,       city, town
code, pref
code,       city
code,             town
code,

pref 必須
code, pref, city, town
      pref, city, town
code, pref,       town
code, pref, city,
      pref,       town
code, pref
      pref, city
      pref

city 必須
code, pref, city, town
      pref, city, town
code,       city, town
code, pref, city
            city, town
code,       city
      pref, city
            city

town 必須
code, pref, city, town
      pref, city, town
code,       city, town
code, pref,       town
            city, town
code,             town
      pref,       town
                  town
