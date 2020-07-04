# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit font

DESCRIPTION="This is SARASA GOTHIC, a CJK programming font based on Iosevka and Source Han Sans."
HOMEPAGE="https://github.com/be5invis/Sarasa-Gothic"
SRC_URI="https://github.com/be5invis/Sarasa-Gothic/releases/download/v${PV}/sarasa-gothic-ttc-${PV}.7z"

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~mips ~ppc ~ppc64 ~sparc ~x86"
FONT_SUFFIX="ttc"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="app-arch/p7zip"

S="${WORKDIR}"
