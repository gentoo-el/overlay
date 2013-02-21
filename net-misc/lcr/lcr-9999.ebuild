# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gnuradio/gnuradio-3.6.0.ebuild,v 1.3 2012/05/06 13:38:45 chithanh Exp $

EAPI=4
PYTHON_DEPEND="2"

inherit base cmake-utils fdo-mime python git-2

DESCRIPTION="Linux Call Router"
HOMEPAGE="http://isdn.eversberg.eu/"
EGIT_REPO_URI="git://git.misdn.eu/lcr.git/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_prepare() {
#	sed -i "s/UNKNOWN/${PV}/" git-version-gen || die
	sh ./autogen.sh
	eautoreconf
}

src_configure() {
	econf --with-gsm-bs
}

src_compile() {
	emake
}

src_install() {
	emake install
}

