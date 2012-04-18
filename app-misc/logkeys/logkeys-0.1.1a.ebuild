# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="A GNU/Linux keylogger that works!"
HOMEPAGE="http://code.google.com/p/logkeys/"
SRC_URI="http://logkeys.googlecode.com/files/logkeys-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv *-${PN}-* "${S}"
}

src_compile() {
	tc-export CC
	emake || die
}

