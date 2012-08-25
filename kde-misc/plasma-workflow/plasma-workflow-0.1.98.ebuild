# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_LIGNUAS="el"
inherit kde4-base

MY_PN="plasmoid-workflow"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Plasmoid version derived from the WorkFlow project"
HOMEPAGE="http://workflow.opentoolsandspace.org/"
SRC_URI="http://opentoolsandspace.org/Art/WorkFlow/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
	$(add_kdebase_dep plasma-workspace)
	$(add_kdebase_dep kactivities)"
S=${WORKDIR}/${MY_P}

PATCHES=(
	"${FILESDIR}/${P}_desktop_qa_fix.patch"
)
