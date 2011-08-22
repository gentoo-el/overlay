# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils versionator webapp git-2

DESCRIPTION="Django CMS with LDAP frontend and a WYSIWYG editor"
HOMEPAGE="http://infrastructure.gentoo.org"
EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/okupy"

LICENSE="AGPLv3"
SLOT="0"
KEYWORDS=""
IUSE="ldap mysql postgres sqlite"

RDEPEND="
	>=dev-python/django-1.3
	>=dev-python/lxml-2.3
	>=dev-python/mysql-python-1.2.3
	>=dev-python/python-ldap-2.3.13
	>=dev-python/pycrypto-2.3
	>=dev-python/simplejson-1.7.1
	ldap? ( >=net-nds/openldap-2.4.24 )
	mysql? ( >=dev-python/mysql-python-1.2.1_p2 )
	postgres? ( dev-python/psycopg )
	sqlite? ( 
		|| ( dev-lang/python:2.7[sqlite] dev-lang/python:2.6[sqlite]
		dev-lang/python:2.5[sqlite] dev-python/pysqlite:2 )
	)"
#DEPEND="${RDEPEND}
#	doc? ( >=dev-python/sphinx-0.3 )
#	test? ( || ( dev-lang/python:2.7[sqlite] dev-lang/python:2.6[sqlite] dev-lang/python:2.5[sqlite] dev-python/pysqlite:2 ) )"

S="${WORKDIR}"

#DOCS="docs/* AUTHORS"
WEBAPP_MANUAL_SLOT="yes"

pkg_setup() {
	python_pkg_setup
	webapp_pkg_setup
}

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
	webapp_src_install
}

pkg_postinst() {
	bash-completion_pkg_postinst
	distutils_pkg_postinst

	einfo "Now, ${PN} has the best of both worlds with Gentoo,"
	einfo "ease of deployment for production and development."
	echo
	elog "A copy of the admin media is available to"
	elog "webapp-config for installation in a webroot,"
	elog "as well as the traditional location in python's"
	elog "site-packages dir for easy development"
	echo
	ewarn "If you build ${PN} without USE=\"vhosts\""
	ewarn "webapp-config will automatically install the"
	ewarn "admin media into the localhost webroot."
}
