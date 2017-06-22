# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="A C/C++ IDE from jetBrains."
HOMEPAGE="https://www.jetbrains.com/clion"
SRC_URI="https://download.jetbrains.com/cpp/CLion-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_install() {
	insinto /opt
	doins -r ${P}
	fperms a+x /opt/${P}/bin/{clion.sh,fsnotifier{,64,-arm},format.sh,inspect.sh,restart.py,printenv.py} || die
	fperms a+x /opt/${P}/bin/gdb/bin/gdb{,server} || die
	fperms a+x /opt/${P}/bin/lldb/bin/lldb-server || die
	fperms a+x /opt/${P}/bin/lldb/LLDBFrontend || die
	fperms a+x /opt/${P}/bin/cmake/bin/c{make,pack,test} || die
	fperms a+x /opt/${P}/jre64/bin/{java,keytool,pack200,rmid,servertool,unpack200,jjs,orbd,policytool,rmiregistry,tnameserv} || die
	dosym /opt/${P}/bin/clion.sh /usr/bin/clion
	newicon "${P}/bin/${PN}.svg" "${PN}.svg"
}
