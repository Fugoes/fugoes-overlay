# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils

DESCRIPTION="Obsidian is a powerful knowledge base that works on top of a local folder of plain text Markdown files."
HOMEPAGE="https://obsidian.md/"
SRC_URI="https://github.com/obsidianmd/obsidian-releases/releases/download/v0.8.2/Obsidian-${PV}.AppImage"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

QA_PREBUILT="*"

S="${WORKDIR}"

src_unpack() {
	cp -L ${DISTDIR}/${A} ${S}
	chmod +x ${S}/${A}
	${S}/${A} --appimage-extract
}

src_install() {
	mkdir -p "${D}/opt"
	mv ${S}/squashfs-root "${D}/opt/obsidian-bin-${PV}"
	chmod -R 755 "${D}/opt/obsidian-bin-${PV}"
	make_wrapper "obsidian" "/opt/obsidian-bin-${PV}/AppRun"
	make_desktop_entry "obsidian" "obsidian" "obsidian"
}
