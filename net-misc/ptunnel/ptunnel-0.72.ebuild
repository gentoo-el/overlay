# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils toolchain-funcs

MY_PN="PingTunnel"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Reliably tunnel TCP connections over ICMP packets"
HOMEPAGE="http://www.cs.uit.no/~daniels/PingTunnel/"
SRC_URI="http://www.cs.uit.no/~daniels/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc selinux"

DEPEND="
		net-libs/libpcap
		selinux? ( sys-libs/libselinux )
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_PN}

src_prepare(){
	epatch "${FILESDIR}"/${P}_makefile.patch
}

src_compile() {
	tc-export CC
	emake $(usex selinux "SELINUX=1" "SELINUX=0")
}

src_install() {
	default
	use doc && dohtml web/*
}
