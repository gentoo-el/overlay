# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="A simple and stupid load testing tool for DNS resolvers"
HOMEPAGE="https://github.com/jedisct1/dnsblast"
SRC_URI="https://github.com/jedisct1/${PN}/tarball/master -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv *-${P}-* "${S}"
}

src_compile() {
	tc-export CC
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README.markdown
}
