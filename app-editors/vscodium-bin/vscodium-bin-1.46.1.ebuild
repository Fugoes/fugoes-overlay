# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils

DESCRIPTION="VSCodium is a community-driven, freely-licensed binary distribution of Microsoft’s editor VSCode."
HOMEPAGE="https://vscodium.com/"
SRC_URI="amd64? ( https://github.com/VSCodium/vscodium/releases/download/1.46.1/VSCodium-linux-x64-1.46.1.tar.gz )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="vscode-marketplace"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

QA_PREBUILT="opt/${P}/*"

src_configure() {
	if use vscode-marketplace; then
		eapply "${FILESDIR}/vscode-marketplace.patch"
	fi
}

src_install() {
	local DIR="/opt/${P}"
	dodir "${DIR}"
	cp -ra "${S}/." "${D}/${DIR}"
	chmod 755 "${D}/${DIR}"
	make_wrapper "codium" "${DIR}/bin/codium"
	make_desktop_entry "codium" "codium" "codium" "Development;X-Editor;"
}
