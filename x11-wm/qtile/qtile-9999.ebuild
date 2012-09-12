# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit python git distutils

DESCRIPTION="QTile -- Python WM for Hackers"
HOMEPAGE="http://qtile.org"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/libxcb
x11-libs/xpyb
x11-libs/cairo
dev-python/pycairo"


RDEPEND="${DEPEND}"

EGIT_REPO_URI="git://github.com/cortesi/qtile.git"
EGIT_BRANCH="master"
EGIT_COMMIT="588645e6011fb5aa234445c74c1c9bb118483714"
S="${WORKDIR}"/${PN}

src_install() { 
	distutils_src_install 
	install -d ${D}/usr/share/doc/${PF}
	cp -r ${S}/examples ${D}/usr/share/doc/${PF}
	install -d ${D}/etc/X11/Sessions
	cp ${FILESDIR}/qtile ${D}/etc/X11/Sessions/qtile
	chmod 755 ${D}/etc/X11/Sessions/qtile
}

pkg_postinst() {
	einfo
	einfo "You need to create a configuration file for QTile"
	einfo "It is probably the easiest to start with one of the configration files"
	einfo "in /usr/share/doc/${PF}/examples/config directory"
	einfo "   install -d ~/.config/qtile"
	einfo "   cp /usr/share/doc/${PF}/examples/config/cortesi-config.py ~/.config/qtile/config.py"
	einfo
	einfo "If you don't use a loginmanager you need to add the following to your .xsession file"
	einfo "   exec /usr/bin/qtile"
}
