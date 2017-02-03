# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="5"
SLOT="0"
DESCRIPTION="A minimal Markdown reading & writing app."
HOMEPAGE="https://typora.io"
KEYWORDS="~amd64"
LICENSE="Typora"
SRC_URI="https://typora.io/./linux/typora_0.9.23_amd64.deb"
RESTRICT="mirror"
S=${WORKDIR}

src_compile() {
	tar xf ${WORKDIR}/data.tar.xz
	rm control.tar.gz data.tar.xz debian-binary
	rm usr/doc usr/lintian -rf
}

src_install() {
	dodir /usr/share/typora
	insinto /usr/share/typora
	insopts -m0755
	doins -r ${S}/usr/share/typora/*

	dodir /usr/share/applications
	insinto /usr/share/applications
	doins ${S}/usr/share/applications/typora.desktop

	dodir /usr/share/icons
	insinto /usr/share/icons
	doins -r ${S}/usr/share/icons/hicolor

	dodir /usr/bin
	dosym -r typora ../share/typora/Typora
}

pkg_postinst(){
	einfo
	einfo "this is a test"
	einfo
}
