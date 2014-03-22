# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit fdo-mime versionator

S=${WORKDIR}
MY_PV=$(get_after_major_version)

DESCRIPTION="Stream movies from torrents. Skip the downloads. Launch, click, watch."
HOMEPAGE="http://popcorn.cdnjd.com/"
SRC_URI="https://raw.githubusercontent.com/popcorn-team/popcorn-app/v${PV}-beta/images/icon.png
x86?   ( http://popcorn.cdnjd.com/releases/Popcorn-Time-${MY_PV}-Linux-32.tgz )
amd64? ( http://popcorn.cdnjd.com/releases/Popcorn-Time-${MY_PV}-Linux-64.tgz )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="strip splitdebug"

DEPEND=""
RDEPEND="x11-libs/gtk+:2
	gnome-base/gconf
	dev-libs/nss
	media-libs/alsa-lib
	media-fonts/corefonts"

src_install() {
	exeinto /opt/${PN}
	doexe Popcorn-Time libffmpegsumo.so nw.pak
	doexe "${FILESDIR}"/${PN}

	dosym /lib/libudev.so.1 /opt/${PN}/libudev.so.0
	dosym /opt/${PN}/${PN} /opt/bin/${PN}

	insinto /usr/share/applications
	doins "${FILESDIR}"/${PN}.desktop

	insinto /usr/share/pixmaps
	newins "${DISTDIR}"/icon.png ${PN}.png
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
