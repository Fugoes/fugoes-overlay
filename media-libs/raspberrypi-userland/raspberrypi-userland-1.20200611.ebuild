# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils flag-o-matic git-r3

DESCRIPTION="Raspberry Pi userspace tools and libraries"
HOMEPAGE="https://github.com/raspberrypi/userland"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm ~arm64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
IDEPEND="dev-util/patchelf"

EGIT_REPO_URI="https://github.com/raspberrypi/userland"
# latest commit, as of of ebuild's version (datestamp)
EGIT_COMMIT="f97b1af1b3e653f9da2c1a3643479bfd469e3b74"

pkg_setup() {
	append-ldflags $(no-as-needed)
}

src_configure() {
	if use arm64; then
		mycmakeargs+=(-DARM64=ON)
	fi
	cmake -DCMAKE_BUILD_TYPE=Release ${mycmakeargs} "../raspberrypi-userland-1.20200611"
}

src_compile() {
	emake
}

src_install() {
	emake install DESTDIR="${D}"
	for x in dtmerge dtoverlay tvservice vcgencmd vchiq_test vcmailbox; do
		patchelf --set-rpath '$ORIGIN/../lib' "${D}/opt/vc/bin/${x}"
	done
}
