# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="dummy ebuild for puppet portage provider testing"
HOMEPAGE="https://github.com/gentoo/puppet-portage"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X doc pam"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	dodir /var/lib/"${P}"
	touch "${ED}"/var/lib/"${P}"/installed
	use X && touch "${ED}"/var/lib/"${P}"/X
	use doc && touch "${ED}"/var/lib/"${P}"/doc
	use pam && touch "${ED}"/var/lib/"${P}"/pam
}
