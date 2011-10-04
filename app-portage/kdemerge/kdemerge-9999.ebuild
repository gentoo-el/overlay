# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2

DESCRIPTION="KDE app to set up a KDE Development environment"
HOMEPAGE="http://github.com/terietor/kdemerge"
EGIT_REPO_URI="git://github.com/terietor/kdemerge.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	#${FILESDIR}/gitconfig

	exeinto /usr/local/bin
	newexe ${FILESDIR}/git-wrapper git

	exeinto /usr/local/bin
	doexe ${FILESDIR}/create_repolinks
}

