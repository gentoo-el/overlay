# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit distutils

MY_P=${P/_/-}
DESCRIPTION="xml2po-gentoo - fork from xml2po for gentoo-doc-ru purposes"
HOMEPAGE="https://projects.gentoo.ru/projects/gentoo-doc-ru"
SRC_URI="https://projects.gentoo.ru/attachments/download/38/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="dev-libs/libxml2
	sys-devel/gettext"

S="${WORKDIR}"/${MY_P}

src_install() {
	distutils_src_install
	doman doc/xml2po-gentoo.1
	dohtml doc/xml2po-gentoo.1.html
}
