# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit vim-plugin

DESCRIPTION="vim plugin: Puppet configuration files syntax"
HOMEPAGE="http://puppetlabs.com/"
SRC_URI="http://dev.gentoo.org/~tampakrap/tarballs/${P}.tar.bz2"
LICENSE="Apache-2.0 GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides syntax highlighting for Puppet configuration
files."

DEPEND="!<app-admin/puppet-2.7.18"
