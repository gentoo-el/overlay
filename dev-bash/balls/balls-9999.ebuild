# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils git-2

DESCRIPTION="Fully-featured web platform in bash"
HOMEPAGE="https://github.com/jayferd/balls"
EGIT_REPO_URI="git://github.com/jayferd/balls.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	exeinto /usr/$(get_libdir)
	doexe lib/*

	exeinto /usr/bin
	doexe bin/*
}
