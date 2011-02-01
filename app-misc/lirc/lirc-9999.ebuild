# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils linux-mod flag-o-matic autotools cvs

DESCRIPTION="decode and send infra-red signals of many commonly used remote controls"
HOMEPAGE="http://www.lirc.org/"
SRC_URI=""

ECVS_SERVER="lirc.cvs.sourceforge.net:/cvsroot/${PN}"
ECVS_MODULE="${PN}"
ECVS_ANON="yes"
ESVC_USER="anonymous"
ECVS_CVS_OPTIONS="-d"

S="${WORKDIR}/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug doc X hardware-carrier transmitter"

RDEPEND="
	X? (
		x11-libs/libX11
		x11-libs/libSM
		x11-libs/libICE
	)
	lirc_devices_alsa_usb? ( media-libs/alsa-lib )
	lirc_devices_audio? ( >media-libs/portaudio-18 )
	lirc_devices_irman? ( media-libs/libirman )"

# This are drivers with names matching the
# parameter --with-driver=NAME
IUSE_LIRC_DEVICES_DIRECT="
	all userspace accent act200l act220l
	adaptec alsa_usb animax asusdh atilibusb
	atiusb audio audio_alsa avermedia avermedia_vdomate
	avermedia98 awlibusb bestbuy bestbuy2 breakoutbox
	bte bw6130 caraca chronos commandir
	cph06x creative creative_infracd
	devinput digimatrix dsp dvico ea65 ene0100
	exaudio flyvideo ftdi gvbctv5pci hauppauge
	hauppauge_dvb hercules_smarttv_stereo i2cuser
	igorplugusb iguanaIR imon imon_24g imon_knob
	imon_lcd imon_pad imon_rsc irdeo irdeo_remote
	irlink irman irreal it87 ite8709
	knc_one kworld leadtek_0007 leadtek_0010
	leadtek_pvr2000 livedrive_midi
	livedrive_seq logitech macmini mceusb
	mediafocusI mouseremote
	mouseremote_ps2 mp3anywhere mplay nslu2
	packard_bell parallel pcmak pcmak_usb
	pctv pixelview_bt878 pixelview_pak
	pixelview_pro provideo realmagic
	remotemaster sa1100 samsung sasem sb0540 serial
	silitek sir slinke streamzap tekram
	tekram_bt829 tira ttusbir tuxbox tvbox udp uirt2
	uirt2_raw usb_uirt_raw usbx wpc8769l"

# drivers that need special handling and
# must have another name specified for
# parameter --with-driver=NAME
IUSE_LIRC_DEVICES_SPECIAL="
	serial_igor_cesko
	remote_wonder_plus xboxusb usbirboy inputlirc"

IUSE_LIRC_DEVICES="${IUSE_LIRC_DEVICES_DIRECT} ${IUSE_LIRC_DEVICES_SPECIAL}"

#device-driver which use libusb
LIBUSB_USED_BY_DEV="
	all atilibusb awlibusb sasem igorplugusb imon imon_lcd imon_pad
	imon_rsc streamzap mceusb xboxusb irlink commandir"

for dev in ${LIBUSB_USED_BY_DEV}; do
	DEPEND="${DEPEND} lirc_devices_${dev}? ( dev-libs/libusb )"
done

# adding only compile-time depends
DEPEND="${RDEPEND} ${DEPEND}
	virtual/linux-sources
	lirc_devices_ftdi? ( dev-embedded/libftdi )
	lirc_devices_all? ( dev-embedded/libftdi )"

# adding only run-time depends
RDEPEND="${RDEPEND}
	lirc_devices_usbirboy? ( app-misc/usbirboy )
	lirc_devices_inputlirc? ( app-misc/inputlircd )
	lirc_devices_iguanaIR? ( app-misc/iguanaIR )"

# add all devices to IUSE
for dev in ${IUSE_LIRC_DEVICES}; do
	IUSE="${IUSE} lirc_devices_${dev}"
done

add_device() {
	: ${lirc_device_count:=0}
	((lirc_device_count++))

	if [[ ${lirc_device_count} -eq 2 ]]; then
		ewarn
		ewarn "When selecting multiple devices for lirc to be supported,"
		ewarn "it can not be guaranteed that the drivers play nice together."
		ewarn
		ewarn "If this is not intended, then abort emerge now with Ctrl-C,"
		ewarn "Set LIRC_DEVICES and restart emerge."
		ewarn
		epause
	fi

	local dev="${1}"
	local desc="device ${dev}"
	if [[ -n "${2}" ]]; then
		desc="${2}"
	fi

	elog "Compiling support for ${desc}"
	MY_OPTS="${MY_OPTS} --with-driver=${dev}"
}

pkg_setup() {

	if use lirc_devices_mceusb2
	then
		ewarn "The mceusb2 driver has been merged into the mceusb."
		ewarn "Please only use the latter now."
	fi

	ewarn "If your LIRC device requires modules, you'll need MODULE_UNLOAD"
	ewarn "support in your kernel."

	linux-mod_pkg_setup

	# set default configure options
	MY_OPTS=""
	LIRC_DRIVER_DEVICE="/dev/lirc0"

	if use lirc_devices_all; then
		# compile in drivers for a lot of devices
		add_device all "a lot of devices"
	else
		# compile in only requested drivers
		local dev
		for dev in ${IUSE_LIRC_DEVICES_DIRECT}; do
			if use lirc_devices_${dev}; then
				add_device ${dev}
			fi
		done

		if use lirc_devices_remote_wonder_plus; then
			add_device atiusb "device Remote Wonder Plus (atiusb-based)"
		fi

		if use lirc_devices_serial_igor_cesko; then
			add_device serial "serial with Igor Cesko design"
			MY_OPTS="${MY_OPTS} --with-igor"
		fi

		if use lirc_devices_imon_pad; then
			ewarn "The imon_pad driver has incorporated the previous pad2keys patch"
			ewarn "and removed the pad2keys_active option for the lirc_imon module"
			ewarn "because it is always active."
			ewarn "If you have an older imon VFD device, you may need to add the module"
			ewarn "option display_type=1 to override autodetection and force VFD mode."
		fi

		if use lirc_devices_xboxusb; then
			add_device atiusb "device xboxusb"
		fi

		if use lirc_devices_usbirboy; then
			add_device userspace "device usbirboy"
			LIRC_DRIVER_DEVICE="/dev/usbirboy"
		fi

		if [[ "${MY_OPTS}" == "" ]]; then
			if [[ "${PROFILE_ARCH}" == "xbox" ]]; then
				# on xbox: use special driver
				add_device atiusb "device xboxusb"
			else
				# no driver requested
				elog
				elog "Compiling only the lirc-applications, but no drivers."
				elog "Enable drivers with LIRC_DEVICES if you need them."
				MY_OPTS="--with-driver=none"
			fi
		fi
	fi

	use hardware-carrier && MY_OPTS="${MY_OPTS} --without-soft-carrier"
	use transmitter && MY_OPTS="${MY_OPTS} --with-transmitter"

	if [[ -n "${LIRC_OPTS}" ]] ; then
		ewarn
		ewarn "LIRC_OPTS is deprecated from lirc-0.8.0-r1 on."
		ewarn
		ewarn "Please use LIRC_DEVICES from now on."
		ewarn "e.g. LIRC_DEVICES=\"serial sir\""
		ewarn
		ewarn "Flags are now set per use-flags."
		ewarn "e.g. transmitter, hardware-carrier"

		local opt
		local unsupported_opts=""

		# test for allowed options for LIRC_OPTS
		for opt in ${LIRC_OPTS}; do
			case ${opt} in
				--with-port=*|--with-irq=*|--with-timer=*|--with-tty=*)
					MY_OPTS="${MY_OPTS} ${opt}"
					;;
				*)
					unsupported_opts="${unsupported_opts} ${opt}"
					;;
			esac
		done
		if [[ -n ${unsupported_opts} ]]; then
			ewarn "These options are no longer allowed to be set"
			ewarn "with LIRC_OPTS: ${unsupported_opts}"
			die "LIRC_OPTS is no longer recommended."
		fi
	fi

	# Setup parameter for linux-mod.eclass
	MODULE_NAMES="lirc(misc:${S})"
	BUILD_TARGETS="all"

	ECONF_PARAMS="	--localstatedir=/var
					--with-syslog=LOG_DAEMON
					--enable-sandboxed
					--with-kerneldir=${KV_DIR}
					--with-moduledir=/lib/modules/${KV_FULL}/misc
					$(use_enable debug)
					$(use_with X x)
					${MY_OPTS}"

	einfo
	einfo "lirc-configure-opts: ${MY_OPTS}"
	elog  "Setting default lirc-device to ${LIRC_DRIVER_DEVICE}"

	filter-flags -Wl,-O1

	# force non-parallel make, Bug 196134
	MAKEOPTS="${MAKEOPTS} -j1"
}

src_unpack() {
	cvs_src_unpack
	cd "${S}"

	# Rip out dos CRLF
	edos2unix contrib/lirc.rules

	# Apply patches needed for some special device-types
	use lirc_devices_audio || epatch "${FILESDIR}"/lirc-0.8.4-portaudio_check.patch
	use lirc_devices_remote_wonder_plus && epatch "${FILESDIR}"/lirc-0.8.3_pre1-remotewonderplus.patch

	# remove parallel driver on SMP systems
	if linux_chkconfig_present SMP ; then
		sed -i -e "s:lirc_parallel\.o::" drivers/lirc_parallel/Makefile.am
	fi

	# Bug #187418
	if kernel_is ge 2 6 22 ; then
		ewarn "Disabling lirc_gpio driver as it does no longer work Kernel 2.6.22+"
		sed -i -e "s:lirc_gpio\.o::" drivers/lirc_gpio/Makefile.am
	fi

	# respect CFLAGS
	sed -i -e 's:CFLAGS="-O2:CFLAGS=""\n#CFLAGS="-O2:' configure.ac

	# setting default device-node
	local f
	for f in configure.ac acconfig.h; do
		[[ -f "$f" ]] && sed -i -e '/#define LIRC_DRIVER_DEVICE/d' "$f"
	done
	echo "#define LIRC_DRIVER_DEVICE \"${LIRC_DRIVER_DEVICE}\"" >> acconfig.h

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	newinitd "${FILESDIR}"/lircd-0.8.6 lircd
	newinitd "${FILESDIR}"/lircmd lircmd
	newconfd "${FILESDIR}"/lircd.conf.2 lircd

	insinto /etc/modprobe.d/
	newins "${FILESDIR}"/modprobed.lirc lirc.conf

	newinitd "${FILESDIR}"/irexec-initd-0.8.6-r2 irexec
	newconfd "${FILESDIR}"/irexec-confd irexec

	if use doc ; then
		dohtml doc/html/*.html
		insinto /usr/share/doc/${PF}/images
		doins doc/images/*
	fi

	insinto /usr/share/lirc/remotes
	doins -r remotes/*

	keepdir /var/run/lirc /etc/lirc
	if [[ -e "${D}"/etc/lirc/lircd.conf ]]; then
		newdoc "${D}"/etc/lirc/lircd.conf lircd.conf.example
	fi
}

pkg_preinst() {
	linux-mod_pkg_preinst

	local dir="${ROOT}/etc/modprobe.d"
	if [[ -a "${dir}"/lirc && ! -a "${dir}"/lirc.conf ]]; then
		elog "Renaming ${dir}/lirc to lirc.conf"
		mv -f "${dir}/lirc" "${dir}/lirc.conf"
	fi

	# copy the first file that can be found
	if [[ -f "${ROOT}"/etc/lirc/lircd.conf ]]; then
		cp "${ROOT}"/etc/lirc/lircd.conf "${T}"/lircd.conf
	elif [[ -f "${ROOT}"/etc/lircd.conf ]]; then
		cp "${ROOT}"/etc/lircd.conf "${T}"/lircd.conf
		MOVE_OLD_LIRCD_CONF=1
	elif [[ -f "${D}"/etc/lirc/lircd.conf ]]; then
		cp "${D}"/etc/lirc/lircd.conf "${T}"/lircd.conf
	fi

	# stop portage from touching the config file
	if [[ -e "${D}"/etc/lirc/lircd.conf ]]; then
		rm -f "${D}"/etc/lirc/lircd.conf
	fi
}

pkg_postinst() {
	linux-mod_pkg_postinst

	# copy config file to new location
	# without portage knowing about it
	# so it will not delete it on unmerge or ever touch it again
	if [[ -e "${T}"/lircd.conf ]]; then
		cp "${T}"/lircd.conf "${ROOT}"/etc/lirc/lircd.conf
		if [[ "$MOVE_OLD_LIRCD_CONF" = "1" ]]; then
			elog "Moved /etc/lircd.conf to /etc/lirc/lircd.conf"
			rm -f "${ROOT}"/etc/lircd.conf
		fi
	fi

	ewarn
	ewarn "The lirc_gpio driver will not work with Kernels 2.6.22+"
	ewarn "You need to switch over to /dev/input/event? if you need gpio"
	ewarn "This device can than then be used via lirc's dev/input driver."
	ewarn
	ewarn "The new default location for lircd.conf is inside of"
	ewarn "/etc/lirc/ directory"

}
