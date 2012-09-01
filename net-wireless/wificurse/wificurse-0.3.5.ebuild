# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils toolchain-funcs vcs-snapshot

DESCRIPTION="Wificurse is a wifi jamming tool"
HOMEPAGE="https://github.com/oblique/wificurse/"
SRC_URI="https://github.com/oblique/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	tc-export CC
	emake
}

src_install() {
	emake install DESTDIR="${D}"
}
