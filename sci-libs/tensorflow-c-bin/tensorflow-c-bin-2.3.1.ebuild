# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="TensorFlow C library"
HOMEPAGE="https://www.tensorflow.org/install/lang_c"
SRC_URI="
	gpu? ( https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-gpu-linux-x86_64-${PV}.tar.gz )
	!gpu? ( https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-linux-x86_64-${PV}.tar.gz )"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE="gpu"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	insinto "/usr/include"
	doins -r "include/tensorflow"
	rm -rf "include"
	insinto "/usr/lib64"
	doins -r lib/*
}
