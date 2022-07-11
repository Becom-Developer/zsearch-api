#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use FindBin;
use lib ( "$FindBin::RealBin/../lib", "$FindBin::RealBin/../local/lib/perl5" );
use Zsearch;
Zsearch->new->CGI->run;

__END__
