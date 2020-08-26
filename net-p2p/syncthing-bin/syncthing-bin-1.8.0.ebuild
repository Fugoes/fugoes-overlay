# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit user

MY_PN=${PN/-bin/}
MY_PV=${PV}
S=${WORKDIR}/${MY_PN}-${KERNEL}-${ARCH}-v${MY_PV}

DESCRIPTION="Syncthing is a continuous file synchronization program."
HOMEPAGE="https://syncthing.net/"
SRC_URI="
	amd64? ( https://github.com/syncthing/syncthing/releases/download/v${MY_PV}/syncthing-linux-amd64-v${MY_PV}.tar.gz )
	arm64? ( https://github.com/syncthing/syncthing/releases/download/v${MY_PV}/syncthing-linux-arm64-v${MY_PV}.tar.gz )"

LICENSE="Apache-2.0 BSD BSD-2 ISC MIT MPL-2.0 Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup syncthing
	enewuser syncthing -1 -1 /var/lib/syncthing syncthing
}

src_install() {
	into /usr
	dobin syncthing
	newconfd "${FILESDIR}/syncthing.confd" syncthing
	newinitd "${FILESDIR}/syncthing.initd" syncthing
	keepdir /var/{lib,log}/syncthing
	fowners syncthing:syncthing /var/{lib,log}/syncthing
	insinto /etc/logrotate.d
	newins "${FILESDIR}/syncthing.logrotate" syncthing
}
