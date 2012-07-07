# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
KDE_REQUIRED="optional"
inherit cmake-utils kde4-base

DESCRIPTION="Cantata is a client for the music player daemon (MPD)"
HOMEPAGE="http://kde-apps.org/content/show.php?content=147733"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="kde"

DEPEND="media-libs/taglib"
RDEPEND=${DEPEND}

src_configure() {
	local mycmakeargs
	if use kde; then
		mycmakeargs=(
			$(cmake-utils_use_want kde KDE_SUPPORT)
		)
		kde4-base_src_configure
	else
		cmake-utils_src_configure
	fi
}
