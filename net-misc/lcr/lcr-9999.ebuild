# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils autotools git-2

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
	eautoreconf
	epatch "${FILESDIR}"/${PN}-includes.patch
}

src_configure() {
	econf --with-gsm-bs --without-misdn
}

src_install() {
	emake DESTDIR="${D}" install
}

