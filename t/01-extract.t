# $Id: 01-extract.t 1797 2005-01-28 05:37:13Z btrott $

use strict;
use Test::More tests => 18;
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
is($meta->icon_uri, 'http://example.com/favicon.ico');

$meta = WWW::Blog::Metadata->extract_from_uri('http://btrott.typepad.com/');
ok($meta);
ok($meta->feeds);
is(scalar @{ $meta->feeds }, 2);
is($meta->feeds->[0], 'http://btrott.typepad.com/typepad/atom.xml');
is($meta->feeds->[1], 'http://btrott.typepad.com/typepad/index.rdf');
is($meta->foaf_uri, 'http://btrott.typepad.com/foaf.rdf');
ok(!$meta->lat);
ok(!$meta->lon);
ok(!$meta->icon_uri);
