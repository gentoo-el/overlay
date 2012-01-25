# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

S="${WORKDIR}/${P}-Source"

DESCRIPTION="Network Status is a KDE applet to monitor the network interface status and display it using icons."
HOMEPAGE="http://sourceforge.net/projects/pa-net-stat/"
SRC_URI="http://downloads.sourceforge.net/project/pa-net-stat/${P}-Source.tar.bz2"

SLOT="4"
KEYWORDS="~amd64"
LICENSE="GPL-2"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_configure()
{
      mycmakeargs=( $(cmake-utils_use_want kde KDE4) )
      kde4-base_src_configure
}
