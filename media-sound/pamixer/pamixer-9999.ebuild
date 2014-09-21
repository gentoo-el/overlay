# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="Pulseaudio command line mixer"
HOMEPAGE="https://github.com/cdemoulins/pamixer"
EGIT_REPO_URI="git://github.com/cdemoulins/pamixer.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/boost
		media-sound/pulseaudio"
RDEPEND="${DEPEND}"

src_install() {
	dobin pamixer
}
