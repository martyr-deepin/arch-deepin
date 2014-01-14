# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=deepin-gnome-settings-daemon
pkgver=3.8.99_git20131230103907
pkgrel=1
pkgdesc='A forked gnome-settings-daemon for Linux Deepin'
arch=('i686' 'x86_64')
url="http://www.linuxdeepin.com/"
license=('GPL2')
depends=('dconf' 'gnome-desktop-3-8' 'gsettings-desktop-schemas' 'hicolor-icon-theme' 'libcanberra-pulse' 'libnotify' 'libsystemd' 'libwacom' 'pulseaudio' 'pulseaudio-alsa' 'upower' 'libibus' 'librsvg' 'libgweather' 'geocode-glib' 'geoclue2' 'nss' 'libwnck3')
makedepends=('intltool' 'xf86-input-wacom' 'libxslt' 'docbook-xsl')
provides=('gnome-settings-daemon=3.8')
conflicts=('gnome-settings-daemon')
options=('!emptydirs')
install=gnome-settings-daemon.install

_fileurl=http://packages.linuxdeepin.com/deepin/pool/main/g/gnome-settings-daemon/gnome-settings-daemon_3.8.99+git20131230103907~ef0aae1244.tar.gz
source=("${_fileurl}")
md5sums=('1d0f57284041650e1020bbe339877e16')

_filename="$(basename "${_fileurl}")"
_filename="${_filename%.tar.gz}"
_innerdir="${_filename/_/-}"

_install_copyright_and_changelog() {
    mkdir -p "${pkgdir}/usr/share/doc/${pkgname}"
    cp -f debian/copyright "${pkgdir}/usr/share/doc/${pkgname}/"
    gzip -c debian/changelog > "${pkgdir}/usr/share/doc/${pkgname}/changelog.gz"
}

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

    mkdir -p "${pkgdir}"/usr/lib/gnome-settings-daemon
    gcc -o gnome-settings-daemon/gnome-update-wallpaper-cache debian/gnome-update-wallpaper-cache.c `pkg-config --cflags --libs glib-2.0 gdk-3.0 gdk-x11-3.0 gio-2.0 gnome-desktop-3.0`
	install -m 0755 gnome-settings-daemon/gnome-update-wallpaper-cache "${pkgdir}"/usr/lib/gnome-settings-daemon/

    mkdir -p "${pkgdir}"/usr/share/apport/package-hooks
    cp -vf debian/source_gnome-settings-daemon.py "${pkgdir}"/usr/share/apport/package-hooks/

    mkdir -p "${pkgdir}"/usr/bin
    ln -sf /usr/lib/gnome-settings-daemon/gnome-settings-daemon "${pkgdir}"/usr/bin/gnome-settings-daemon

    _install_copyright_and_changelog
}
