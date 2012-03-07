 
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

DESCRIPTION="KVirusTotal is an online-based antivirus and anti-phising tool."
HOMEPAGES="http://kde-apps.org/content/show.php/KVirusTotal?content=139065"
SRC_URI="http://kde-apps.org/CONTENT/content-files/139065-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64"
IUSE="kde crypt"

DEPEND="
	dev-libs/qjson
"
RDEPEND=${DEPEND}

src_configure()
{
  mycmakeargs=(	$(cmake-utils_use_want kde KDE4)
		$(cmake-utils_use_with crypt QCA2) )
		kde4-base_src_configure 
}
