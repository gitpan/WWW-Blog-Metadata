# $Id: 02-plugin.t 1811 2005-03-16 22:50:01Z btrott $

use strict;
use Test::More tests => 8;
use WWW::Blog::Metadata;
use File::Spec::Functions;

use constant SAMPLES => catdir 't', 'samples';

my($meta);

## On the first attempt, we have not loaded the plugin, so the
## rsd_uri should not be available.
$meta = WWW::Blog::Metadata->extract_from_uri('http://btrott.typepad.com/');
ok($meta);
ok(!$meta->can('rsd_uri'));
ok(!$meta->can('is_typepad'));
ok(!$meta->can('finished'));

## Set up the @INC so that the plugin can be found...
require lib;
lib->import(catdir 't', 'lib');

## Now we have loaded the plugin, so the rsd_uri will be set after
## calling extract_metadata.
$meta = WWW::Blog::Metadata->extract_from_uri('http://btrott.typepad.com/');
ok($meta);
is($meta->rsd_uri, 'http://www.typepad.com/t/rsd/8');
is($meta->is_typepad, 1);
is($meta->finished, 1);
