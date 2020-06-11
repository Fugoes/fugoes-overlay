# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit user

MY_PN=${PN/-bin/}
MY_PV=${PV/_beta/-beta}
S=${WORKDIR}/${MY_PN}-${MY_PV}

DESCRIPTION="Gorgeous metric viz, dashboards & editors for Graphite, InfluxDB & OpenTSDB"
HOMEPAGE="https://grafana.org"
SRC_URI="
	amd64? ( https://dl.grafana.com/oss/release/grafana-${PV}.linux-amd64.tar.gz )
	arm64? ( https://dl.grafana.com/oss/release/grafana-${PV}.linux-arm64.tar.gz )"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND=""
RDEPEND="${DEPEND}
	media-libs/fontconfig"

pkg_setup() {
	enewgroup grafana
	enewuser grafana -1 -1 /usr/share/grafana grafana
}

src_install() {
	keepdir /etc/grafana
	insinto /etc/grafana
	newins "${S}"/conf/sample.ini grafana.ini

	dobin bin/grafana-cli
	dobin bin/grafana-server
	rm -rf "${S}"/bin

	insinto /usr/share/${MY_PN}
	doins -r *

	doinitd "${FILESDIR}"/grafana

	keepdir /var/{lib,log}/grafana
	keepdir /var/lib/grafana/{dashboards,plugins}
	fowners grafana:grafana /var/{lib,log}/grafana
	fowners grafana:grafana /var/lib/grafana/{dashboards,plugins}
	fperms 0750 /var/{lib,log}/grafana
	fperms 0750 /var/lib/grafana/{dashboards,plugins}
}

postinst() {
	elog "${PN} has built-in log rotation. Please see [log.file] section of"
	elog "/etc/grafana/grafana.ini for related settings."
	elog
	elog "You may add your own custom configuration for app-admin/logrotate if you"
	elog "wish to use external rotation of logs. In this case, you also need to make"
	elog "sure the built-in rotation is turned off."
}
