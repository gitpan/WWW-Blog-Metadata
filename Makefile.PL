# $Id: Makefile.PL 1800 2005-01-28 06:44:44Z btrott $

use inc::Module::Install;

name('WWW-Blog-Metadata');
abstract('Extract common metadata from a weblog');
author('Benjamin Trott <ben+cpan@stupidfool.org>');
version_from('lib/WWW/Blog/Metadata.pm');
license('perl');
no_index(directory => 't');
sign(1);

include('ExtUtils::AutoInstall');

requires('Class::ErrorHandler');
requires('HTML::Parser');
requires('Feed::Find');
requires('URI::Fetch');
requires('Class::Accessor');
requires('Module::Pluggable::Ordered');

auto_include();
auto_install();

&WriteAll;
