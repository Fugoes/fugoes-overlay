# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils

DESCRIPTION="An instant virtual network on your laptop."
HOMEPAGE="http://mininet.org"
SRC_URI="https://github.com/mininet/mininet/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-python/setuptools"
DEPEND="${RDEPEND}
	sys-devel/gcc
	sys-devel/make
	>=net-misc/socat-1.7.3.1
	sys-process/psmisc
	x11-terms/xterm
	virtual/ssh
	net-misc/iperf
	sys-apps/iproute2
	net-misc/telnet-bsd
	dev-libs/libcgroup
	sys-apps/ethtool
	net-misc/openvswitch"

S=${WORKDIR}/${P}

python_compile() {
	distutils-r1_python_compile
	emake mnexec
}

python_install() {
	distutils-r1_python_install
	insinto /usr/bin
	doins mnexec
	fperms a+x /usr/bin/mnexec
}
