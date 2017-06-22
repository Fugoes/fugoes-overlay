# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="A C/C++ IDE from jetBrains."
HOMEPAGE="https://www.jetbrains.com/pycharm"
SRC_URI="https://download.jetbrains.com/python/pycharm-professional-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_install() {
	dodir /opt/${P}
	insinto /opt/${P}
	cd pycharm-${PV}
	doins -r *
	fperms a+x /opt/${P}/bin/{pycharm.sh,fsnotifier{,64,-arm},format.sh,inspect.sh,restart.py,printenv.py} || die
	fperms a+x /opt/${P}/jre64/bin/{java,keytool,pack200,rmid,servertool,unpack200,jjs,orbd,policytool,rmiregistry,tnameserv} || die
	dosym /opt/${P}/bin/pycharm.sh /usr/bin/pycharm
	newicon "bin/pycharm.png" "pycharm.png"
}
