# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/semantik/semantik-0.7.3_p20091013.ebuild,v 1.6 2012/07/25 15:35:43 kensington Exp $

EAPI=4
CMAKE_REQUIRED="never"

inherit kde4-base waf-utils

DESCRIPTION="Mindmapping-like tool for document generation."
HOMEPAGE="http://freehackers.org/~tnagy/semantik.html"
SRC_URI="https://semantik.googlecode.com/files/${P}.tar.bz2"

SLOT="4"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	dev-lang/ocaml
	dev-lang/python
"
RDEPEND="
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-xmlpatterns:4
	dev-lang/python[xml]
"
WAF_BINARY="${S}/waf"
PATCHES=(
	"${FILESDIR}/${P}"-wscript_ldconfig.patch
)

src_configure() {
	CCFLAGS="${CFLAGS}" CPPFLAGS="${CXXFLAGS}" LINKFLAGS="${LDFLAGS}" \
		"${WAF_BINARY}" "--prefix=${EPREFIX}/usr" \
		configure || die "configure failed"
}
