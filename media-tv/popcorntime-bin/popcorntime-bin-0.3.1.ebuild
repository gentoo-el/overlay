# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils fdo-mime multilib

DESCRIPTION="Watch torrent movies instantly"
HOMEPAGE="http://popcorn.cdnjd.com/"
SRC_URI="https://raw.githubusercontent.com/popcorn-official/popcorn-app/master/src/app/images/icon.png
x86?   ( http://cdn.get-popcorn.com/build/Popcorn-Time-${PV}-Linux-32.tar.gz )
amd64? ( http://cdn.get-popcorn.com/build/Popcorn-Time-${PV}-Linux-64.tar.gz )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="splitdebug strip"

DEPEND=""
RDEPEND="dev-libs/nss
	gnome-base/gconf
	media-fonts/corefonts
	media-libs/alsa-lib
	x11-libs/gtk+:2"

S="${WORKDIR}/Popcorn-Time"

src_install() {
	exeinto /opt/${PN}
	doexe Popcorn-Time libffmpegsumo.so package.nw nw.pak

	dosym /$(get_libdir)/libudev.so.1 /opt/${PN}/libudev.so.0
	make_wrapper ${PN} ./Popcorn-Time /opt/${PN} /opt/${PN} /opt/bin

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
