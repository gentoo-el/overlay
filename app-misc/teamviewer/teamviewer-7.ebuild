# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/teamspeak-server-bin/teamspeak-server-bin-3.0.5-r2.ebuild,v 1.1 2012/06/09 17:04:39 trapni Exp $

EAPI=4

DESCRIPTION="Teamviewer remote management software"
HOMEPAGE="http://www.teamviewer.com"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

SRC_URI="http://www.teamviewer.com/download/teamviewer_linux.tar.gz"

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}${PV}

src_install() {

	local dest="${D}/opt/teamviewer"
	mkdir -p "${dest}"
	cp -R "${WORKDIR}/teamviewer"*/. "${dest}" || die
	exeinto /usr/sbin || die
	fperms 755 /opt/teamviewer

}
