# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit fdo-mime

DESCRIPTION="Stream movies from torrents. Skip the downloads. Launch, click, watch."
HOMEPAGE="http://popcorn.cdnjd.com/"
SRC_URI="http://popcorn.cdnjd.com/releases/Popcorn-Time-2.7-Linux-64.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="strip splitdebug"

DEPEND=""
RDEPEND="x11-libs/gtk+:2
	gnome-base/gconf
	dev-libs/nss
	media-libs/alsa-lib"

src_unpack() {
	mkdir ${P}
	cd ${P}
	unpack ${A}
}

src_install() {
	dodir /usr/lib64/popcorntime
	insinto /usr/lib64/popcorntime
	insopts -m755

	doins Popcorn-Time libffmpegsumo.so nw.pak
	doins "${FILESDIR}"/popcorntime

	dosym /lib64/libudev.so.1 /usr/lib64/popcorntime/libudev.so.0
	dosym /usr/lib64/popcorntime/popcorntime /usr/bin/popcorntime

	insinto /usr/share/applications
	doins "${FILESDIR}"/popcorntime.desktop
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
