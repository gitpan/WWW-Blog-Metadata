# $Id: 01-extract.t 1815 2005-03-16 22:54:04Z btrott $

use strict;
use Test::More tests => 16;
use WWW::Blog::Metadata;
use File::Spec::Functions;
use URI::file;

use constant SAMPLES => catdir 't', 'samples';

my($meta);

open my $fh, catfile(SAMPLES, 'blog-full.html')
    or die $!;
my $html = do { local $/; <$fh> };
close $fh;

$meta = WWW::Blog::Metadata->extract_from_html(\$html, 'http://example.com/');
ok($meta);
ok($meta->feeds);
is(scalar @{ $meta->feeds }, 2);
is($meta->feeds->[0], 'http://btrott.typepad.com/typepad/atom.xml');
is($meta->feeds->[1], 'http://btrott.typepad.com/typepad/index.rdf');
is($meta->foaf_uri, 'http://btrott.typepad.com/foaf.rdf');
is($meta->lat, '37.743630');
is($meta->lon, '-122.443182');

$meta = WWW::Blog::Metadata->extract_from_uri('http://btrott.typepad.com/');
ok($meta);
ok($meta->feeds);
is(scalar @{ $meta->feeds }, 2);
is($meta->feeds->[0], 'http://btrott.typepad.com/typepad/atom.xml');
is($meta->feeds->[1], 'http://btrott.typepad.com/typepad/index.rdf');
is($meta->foaf_uri, 'http://btrott.typepad.com/foaf.rdf');
ok(!$meta->lat);
ok(!$meta->lon);
