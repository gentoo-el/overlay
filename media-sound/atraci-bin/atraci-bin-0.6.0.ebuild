# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils fdo-mime multilib

DESCRIPTION="Free music streaming player"
HOMEPAGE="http://getatraci.net/"
SRC_URI="x86?   ( https://github.com/Atraci/Atraci/blob/gh-pages/releases/${PV}/linux32/Atraci.tgz?raw=true -> ${P}-32.tgz )
		 amd64? ( https://github.com/Atraci/Atraci/blob/gh-pages/releases/${PV}/linux64/Atraci.tgz?raw=true -> ${P}-64.tgz )"

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

S="${WORKDIR}/linux64"

src_install() {
	exeinto /opt/${PN}
	doexe Atraci libffmpegsumo.so nw.pak icudtl.dat

	dosym /$(get_libdir)/libudev.so.1 /opt/${PN}/libudev.so.0
	make_wrapper ${PN} ./Atraci /opt/${PN} /opt/${PN} /opt/bin

	insinto /usr/share/applications
	doins "${FILESDIR}"/${PN}.desktop

	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/${PN}.png
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
