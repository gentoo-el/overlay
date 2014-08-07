# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit linux-mod

DESCRIPTION="Realtek PCI Express wireless driver for use in newer kernels"
HOMEPAGE="https://github.com/freestyl3r/rtl8187se"
SRC_URI="https://github.com/freestyl3r/${PN}/archive/${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

MODULE_NAMES="r8187se(net/wireless:${S}:${S})"
CONFIG_CHECK="PCI WIRELESS_EXT WEXT_PRIV EEPROM_93CX6"
BUILD_TARGETS=" "

src_install() {
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
	elog '>>> To avoid conflicts with rtl8180, you can blacklist it with:'
	elog '>>>  `echo "blacklist rtl8180" > /etc/modprobe.d/rtl8180_blacklist.conf`'
}

pkg_postrm() {
	linux-mod_pkg_postrm
}
