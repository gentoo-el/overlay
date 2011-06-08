# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kdevelop"
KDE_SCM="git"
EGIT_REPONAME="kdev-python"
inherit kde4-base

DESCRIPTION="Python plugin for KDevelop 4"
SLOT="4"
KEYWORDS=""
LICENSE="GPL-2"
IUSE="debug"

DEPEND="
	>=dev-util/kdevelop-pg-qt-0.9.0
	dev-util/kdevelop
"
RDEPEND="${DEPEND}"

RESTRICT="test"

src_compile() {
	pushd ${WORKDIR}/kdevelop-python-9999_build
	emake parser
	popd

	kde4-base_src_configure
}
