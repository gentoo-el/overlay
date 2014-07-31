# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="Backup and Restore your system using tar or Transfer it with rsync"
HOMEPAGE="https://github.com/tritonas00/system-tar-and-restore"
EGIT_REPO_URI="git://github.com/tritonas00/system-tar-and-restore.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="ncurses gpt uefi"

DEPEND=""
RDEPEND="net-misc/wget
	net-misc/rsync
	ncurses? ( dev-util/dialog )
	gpt?     ( sys-apps/gptfdisk )
	uefi?    ( sys-fs/dosfstools sys-boot/efibootmgr )"

src_install() {
	into /usr/bin
	doexe backup.sh restore.sh
	doman system-tar-and-restore.1
	dodoc backup.conf
}

pkg_postinst() {
	elog '>>> If you want to use the backup.conf, copy it to the /etc directory:'
	elog '>>> `bzcat /usr/share/doc/system-tar-and-restore-9999/backup.conf.bz2 > /etc/backup.conf`'
}
