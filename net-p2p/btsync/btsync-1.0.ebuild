# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Automatically sync files via secure, distributed technology"
HOMEPAGE="http://labs.bittorrent.com/experiments/sync.html"
SRC_URI="x86?	( https://foss.tesyd.teimes.gr/~tomkap/btsync/${PN}_i386.tar.gz )
	amd64?	( https://foss.tesyd.teimes.gr/~tomkap/btsync/${PN}_x64.tar.gz )"

LICENSE="BitTorrent"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}

src_install() {
	dodoc LICENSE.TXT
	dobin btsync

	newinitd "${FILESDIR}/btsync_initd" btsync
	newconfd "${FILESDIR}/btsync_confd" btsync

	insinto /etc
	doins "${FILESDIR}/btsync.conf"
}
