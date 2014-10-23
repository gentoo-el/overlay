# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Backup and Restore your system using tar or Transfer it with rsync"
HOMEPAGE="https://github.com/tritonas00/system-tar-and-restore"

if [[ ${PV} == *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/tritonas00/system-tar-and-restore.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/tritonas00/system-tar-and-restore/archive/${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="ncurses gpt uefi"

DEPEND=""
RDEPEND="net-misc/wget
	net-misc/rsync[xattr]
	ncurses? ( dev-util/dialog )
	gpt?     ( sys-apps/gptfdisk )
	uefi?    ( sys-fs/dosfstools sys-boot/efibootmgr )
	uefi?    ( sys-boot/grub[grub_platforms_efi-32,grub_platforms_efi-64,grub_platforms_pc] )"

src_install() {
	exeinto /usr/bin
	doexe backup.sh restore.sh
	doman system-tar-and-restore.1
	dodoc backup.conf
}

pkg_postinst() {
	elog '>>> If you want to use the backup.conf, copy it to /etc directory:'
	elog ">>> 'bzcat /usr/share/doc/system-tar-and-restore-${PV}/backup.conf.bz2 > /etc/backup.conf'"
}
