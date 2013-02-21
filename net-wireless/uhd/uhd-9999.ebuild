# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/uhd/uhd-3.5.0.ebuild,v 1.1 $

EAPI=4
PYTHON_DEPEND="2:2.6"

inherit base versionator cmake-utils python git-2

DESCRIPTION="Universal Software Radio Peripheral (USRP) Hardware Driver"
HOMEPAGE="http://code.ettus.com/redmine/ettus/projects/uhd/wiki/"
EGIT_REPO_URI="git://code.ettus.com/ettus/uhd.git" 

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
S="${WORKDIR}"/host
IUSE="examples tests doc"

RDEPEND=">=dev-lang/orc-0.4.12
	dev-libs/boost
	dev-python/cheetah
	dev-libs/libusb:1
	dev-libs/libusb:0[cxx]
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? (
		dev-python/docutils
		>=app-doc/doxygen-1.5.7.1
	)
"

CMAKE_USE_DIR="${S}/host"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -q -r 2 "${S}"
	base_src_prepare
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable examples EXAMPLES)
		$(cmake-utils_use_enable tests TESTS)
		-DENABLE_LIBUHD=ON
		-DENABLE_UTILS=ON
	)
	cmake-utils_src_configure
}

src_install() {
	insinto /lib/udev/rules.d/
	doins "${S}"/utils/uhd-usrp.rules
	insinto /usr/share/${PN}
	doins -r "${WORKDIR}"/"${image_version}"/share/uhd/images
	cmake-utils_src_install
}

