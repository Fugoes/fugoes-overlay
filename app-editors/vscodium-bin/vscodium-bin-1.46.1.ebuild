# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="VSCodium is a community-driven, freely-licensed binary distribution of Microsoft’s editor VSCode."
HOMEPAGE="https://vscodium.com/"
SRC_URI="amd64? ( https://github.com/VSCodium/vscodium/releases/download/1.46.1/VSCodium-linux-x64-1.46.1.tar.gz )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	dodir /opt/vscodium
	cp -ra "${S}/." "${D}/opt/vscodium"
	dosym ../../opt/vscodium/bin/codium /usr/bin/codium
}
