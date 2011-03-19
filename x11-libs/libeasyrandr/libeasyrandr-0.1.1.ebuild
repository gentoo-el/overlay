# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils git cmake-utils

DESCRIPTION="An easy to use c++ library for XRandR"
HOMEPAGE="http://github.com/parapente/libEasyRandR"
SRC_URI="https://github.com/parapente/libEasyRandR/zipball/${PV} -> ${P}.zip"
S="${WORKDIR}/parapente-libEasyRandR-c76573d"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )
		>=x11-libs/qt-core-4.6
		>=x11-libs/libXrandr-1.3"

RDEPEND="${DEPEND}"
