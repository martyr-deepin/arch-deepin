# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=deepin-gnome-settings-daemon
pkgver=3.8.99_{% pkgver %}
pkgrel=1
pkgdesc='A forked gnome-settings-daemon for Linux Deepin'
arch=('i686' 'x86_64')
url="http://www.linuxdeepin.com/"
license=('GPL2')
depends=('dconf' 'gnome-desktop-3-8' 'gsettings-desktop-schemas' 'hicolor-icon-theme' 'libcanberra-pulse' 'libnotify' 'libsystemd' 'libwacom' 'pulseaudio' 'pulseaudio-alsa' 'upower' 'ibus' 'librsvg' 'libgweather' 'geocode-glib' 'geoclue2' 'nss' 'libwnck3')
makedepends=('intltool' 'xf86-input-wacom' 'libxslt' 'docbook-xsl')
provides=('gnome-settings-daemon=3.8')
conflicts=('gnome-settings-daemon')
options=('!emptydirs')
install=gnome-settings-daemon.install

_fileurl={% fileurl %}
source=("${_fileurl}")
md5sums=('{% md5 %}')

_filename="$(basename "${_fileurl}")"
_filename="${_filename%.tar.gz}"
_innerdir="${_filename/_/-}"

build() {
    cd "${srcdir}/${_innerdir}"

    ./autogen.sh
    ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
        --libexecdir=/usr/lib/gnome-settings-daemon --disable-static

    #https://bugzilla.gnome.org/show_bug.cgi?id=656231
    # sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool

    make
}

package() {
    cd "${srcdir}/${_innerdir}"
    make DESTDIR="${pkgdir}" install
}
