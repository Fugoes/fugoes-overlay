# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic cmake-utils

DESCRIPTION="A Persistent Key-Value Store for Flash and RAM Storage"
HOMEPAGE="http://rocksdb.org/"
SRC_URI="https://github.com/facebook/rocksdb/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="|| ( GPL-2 Apache-2.0 ) BSD"
SLOT="0/5"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="minimal rtti bzip2 gflags lz4 snappy tbb tools zlib zstd kernel_linux"

RDEPEND="
	bzip2? ( app-arch/bzip2 )
	gflags? ( dev-cpp/gflags )
	lz4? ( app-arch/lz4 )
	snappy? ( app-arch/snappy )
	tbb? ( dev-cpp/tbb )
	zlib? ( sys-libs/zlib )
	zstd? ( app-arch/zstd )"
DEPEND="${RDEPEND}
	dev-lang/perl:*
	sys-apps/sed"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DUSE_RTTI=$(usex rtti)
		-DFAIL_ON_WARNINGS=OFF
		-DFORCE_SSE42=OFF
		-DPORTABLE=ON
		-DROCKSDB_LITE=$(usex minimal)
		-DWITH_ASAN=OFF
		-DWITH_BZ2=$(usex bzip2)
		-DWITH_FALLOCATE=$(usex kernel_linux)
		-DWITH_GFLAGS=$(usex gflags)
		-DWITH_JEMALLOC=OFF
		-DWITH_JNI=OFF
		-DWITH_LIBRADOS=OFF
		-DWITH_LZ4=$(usex lz4)
		-DWITH_SNAPPY=$(usex snappy)
		-DWITH_TBB=$(usex tbb)
		-DWITH_TESTS=OFF
		-DWITH_TOOLS=$(usex tools)
		-DWITH_TSAN=OFF
		-DWITH_UBSAN=OFF
		-DWITH_ZLIB=$(usex zlib)
		-DWITH_ZSTD=$(usex zstd)
	)
	for x in "-march" "-mcpu" "-mtune"; do
		local old_flag=$(get-flag "$x=" | sed "s/^$x=//")
		if echo "${old_flag}" | grep +crc | grep -q +nocrypto; then
			local new_flag="$(echo "${old_flag}" | sed 's/+crc//')+nocrc"
			einfo "Replace $x=${old_flag} with $x=${new_flag}."
			replace-flags "$x=${old_flag}" "$x=${new_flag}"
		fi
	done
	cmake-utils_src_configure
}
