# $Id: IsTypePad.pm 1798 2005-01-28 06:40:23Z btrott $

package WWW::Blog::Metadata::IsTypePad;
use strict;

use WWW::Blog::Metadata;
WWW::Blog::Metadata->mk_accessors(qw( is_typepad ));

sub on_got_html {
    my $class = shift;
    my($meta, $html, $base_uri) = @_;
    $meta->is_typepad($base_uri =~ /\.typepad\.com/ ? 1 : 0);
}
sub on_got_html_order { 99 }

1;
