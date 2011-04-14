# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KDE_HANDBOOK="optional"
KMNAME="kdepim"
KDE_SCM="git"
inherit kde4-meta
EGIT_REPO_URI="git://git.gentoo-el.org/tampakrap/kdepim-test"
EGIT_BRANCH="trayicon"
EVCS_OFFLINE=1

DESCRIPTION="KDE news feed aggregator."
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep kdepim-common-libs)
"
RDEPEND="${DEPEND}"

KMLOADLIBS="kdepim-common-libs"

add_blocker akregator

src_prepare() {
	echo "add_subdirectory(kontact)" >> "${S}/CMakeLists.txt"

	kde4-meta_src_prepare
}
