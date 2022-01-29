# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="System load plug-in for Xfce panel"
HOMEPAGE="https://goodies.xfce.org/projects/panel-plugins/xfce4-systemload-plugin"
SRC_URI="https://archive.xfce.org/src/panel-plugins/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="*"
IUSE="upower"

RDEPEND=">=xfce-base/libxfce4ui-4.12:=[gtk3(+)]
	>=xfce-base/xfce4-panel-4.12:=
	upower? ( >=sys-power/upower-0.9.23 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

src_configure() {
	econf $(use_enable upower)
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}

