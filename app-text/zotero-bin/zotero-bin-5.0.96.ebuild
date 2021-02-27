# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Zotero is a free, easy-to-use tool to help you collect, organize, cite, and share research."
HOMEPAGE="https://www.zotero.org/"
SRC_URI="https://download.zotero.org/client/release/${PV}/Zotero-${PV}_linux-x86_64.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/Zotero_linux-x86_64"
QA_PREBUILT="*"

src_install() {
	mkdir -p "${D}/opt/zotero"
	cp -ra "${S}/." "${D}/opt/zotero"
	dosym ../../../opt/zotero/zotero.desktop /usr/share/applications/zotero.desktop
}
