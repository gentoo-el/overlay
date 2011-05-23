# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Django LDAP authentication backend"
HOMEPAGE="http://bitbucket.org/psagers/django-auth-ldap/"
SRC_URI="http://pypi.python.org/packages/source/d/django-auth-ldap/${P}.tar.gz"

LICENSE="BSD-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="doc"

PYTHON_MODNAME="django_auth_ldap"

src_install() {
	distutils_src_install
	if use doc; then
		dodoc -r docs
	fi
}

