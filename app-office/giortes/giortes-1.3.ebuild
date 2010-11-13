# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

LINGUAS="el"

EAPI="2"

inherit autotools

DESCRIPTION="Displays the name day that is celebrated"
HOMEPAGE="http://linuxteam.cs.teilar.gr/~forfolias/giortes"
SRC_URI="http://linuxteam.cs.teilar.gr/~forfolias/${PN}/files/src/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="gtk nls"

RDEPEND="gtk? ( >=x11-libs/gtk+-2.16 )"

DEPEND="dev-util/pkgconfig
	nls? ( dev-util/intltool
		sys-devel/gettext )"

for _lingua in ${LINGUAS} ; do
	IUSE="${IUSE} linguas_${_lingua}"
done

src_configure() {
	pushd po > /dev/null
	for lingua in ${LINGUAS} ; do
		if ! use linguas_${lingua} ; then
			rm "${lingua}.po" "${lingua}.gmo"
		fi
	done
	popd > /dev/null

	econf \
		$(use_enable gtk gtk-gui)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
