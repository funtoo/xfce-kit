# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2+ )
PYTHON_REQ_USE='threads(+)'
inherit cmake-utils gnome2-utils multilib python-any-r1

DESCRIPTION="Plugin for thunar that adds context-menu items for dropbox."
HOMEPAGE="https://github.com/Jeinzi/thunar-dropbox"
SRC_URI="https://api.github.com/repos/Jeinzi/thunar-dropbox/tarball/refs/tags/0.3.1 -> thunar-dropbox-0.3.1.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="net-misc/dropbox
>=xfce-base/thunar-1.2"

DEPEND="${RDEPEND}
dev-python/thunarx-python
virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog )

src_unpack() {
	unpack "${A}"
	mv "${WORKDIR}"/Jeinzi-thunar-dropbox-* "${S}" || die
}

src_configure() {
	mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
	)

	cmake-utils_src_configure
}

pkg_preinst()
{ gnome2_icon_savelist; }

pkg_postinst()
{ gnome2_icon_cache_update /usr/share/icons/hicolor; }

pkg_postrm()
{ gnome2_icon_cache_update /usr/share/icons/hicolor; } 
