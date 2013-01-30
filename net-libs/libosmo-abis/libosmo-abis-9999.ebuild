# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libosmocore/libosmocore-9999.ebuild,v 1.3 2012/08/01 23:40:13 chithanh Exp $

EAPI="4"
inherit autotools

if [[ ${PV} == 9999* ]]; then
	inherit git-2
	SRC_URI=""
	EGIT_REPO_URI="git://git.osmocom.org/${PN}.git"
	KEYWORDS=""
fi

DESCRIPTION="Abis implementation for OpenBSC and related projects"
HOMEPAGE="http://bb.osmocom.org/trac/wiki/libosmo-abis"

LICENSE="GPL-2 LGPL-3"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	app-doc/doxygen"

src_prepare() {
	# set correct version in pkgconfig files
	sed -i "s/UNKNOWN/${PV}/" git-version-gen || die
	eautoreconf
}

src_configure() {
	econf 
}

src_install() {
	default
	# install to correct documentation directory
	#mv "${ED}"/usr/share/doc/${PN} "${ED}"/usr/share/doc/${PF} || die
}
