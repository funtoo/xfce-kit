# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools xdg

COMMIT="765725029751bb93a927692fdcda3e3743d0e6e7"

DESCRIPTION="A volume control application and panel plug-in for Xfce"
HOMEPAGE="https://git.xfce.org/apps/xfce4-mixer/"
SRC_URI="https://gitlab.xfce.org/apps/xfce4-mixer/-/archive/${COMMIT}/xfce4-mixer-${COMMIT}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="alsa debug +keybinder pulseaudio sndio"

COMMON_DEPEND=">=dev-libs/glib-2.42
	media-libs/gst-plugins-base:1.0[alsa?]
	>=x11-libs/gtk+-3.14.0:3
	>=xfce-base/libxfce4ui-4.12
	>=xfce-base/libxfce4util-4.12
	>=xfce-base/xfce4-panel-4.12
	>=xfce-base/xfconf-4.12
	keybinder? ( dev-libs/keybinder:3 )
	pulseaudio? ( media-sound/pulseaudio )
	sndio? ( media-sound/sndio )
"
RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	dev-util/xfce4-dev-tools
	sys-devel/gettext
	virtual/pkgconfig"

S="${WORKDIR}/${PN}-${COMMIT}"

src_prepare() {
	# run xdt-autogen from xfce4-dev-tools added as dependency by EAUTORECONF=1 to
	# rename configure.ac.in to configure.ac while grabbing $LINGUAS and $REVISION values
	NOCONFIGURE=1 xdt-autogen || die

	default
}

src_configure() {
	local myconf=(
		$(use_enable keybinder)
		$(use_enable alsa)
		$(use_enable pulseaudio pulse)
		$(use_enable debug)
	)

	econf "${myconf[@]}"
}
