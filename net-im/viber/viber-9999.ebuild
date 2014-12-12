# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils
DESCRIPTION="Free calls, text and picture sharing with anyone, anywhere!"
HOMEPAGE="http://www.viber.com"
SRC_URI="http://download.cdn.viber.com/cdn/desktop/Linux/viber.deb"

SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="strip"
S="${WORKDIR}"

src_unpack() {
	default_src_unpack
	unpack ./data.tar.gz
	epatch "${FILESDIR}/00-desktop.patch"
}

src_install(){
	doins -r opt usr
	fperms 755 /opt/viber/Viber
}

