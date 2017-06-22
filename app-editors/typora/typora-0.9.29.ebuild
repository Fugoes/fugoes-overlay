# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils unpacker

DESCRIPTION="A minimal Markdown reading & writing app."
HOMEPAGE="https://typora.io"
SLOT="0"
KEYWORDS="~amd64"
LICENSE="Typora"
SRC_URI="https://typora.io/./linux/typora_0.9.29_amd64.deb"
RESTRICT="mirror"
RESTRICT="mirror strip"

S="${WORKDIR}"

src_install() {
	insinto /
	doins -r usr

	fperms 0755 /usr/share/typora/Typora

	dodir /usr/share/applications
	insinto /usr/share/applications
	doins ${S}/usr/share/applications/typora.desktop

	dodir /usr/share/icons
	insinto /usr/share/icons
	doins -r ${S}/usr/share/icons/hicolor

	dosym ../share/typora/Typora /usr/bin/typora
}
