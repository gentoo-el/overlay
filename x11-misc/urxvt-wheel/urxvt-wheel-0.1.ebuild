# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 2014/03/03

EAPI=4

inherit eutils vcs-snapshot multilib

DESCRIPTION="Scroll wheel support for urxvt"
HOMEPAGE="https://aur.archlinux.org/packages/urxvt-vtwheel/"
SRC_URI="https://dl.dropboxusercontent.com/u/1987095/${P}.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="x11-terms/rxvt-unicode[perl]"

src_install() {
	insinto /usr/$(get_libdir)/urxvt/perl
	doins vtwheel
}
