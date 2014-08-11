# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname='libdtk-widget'
pkgver=git20131206101523
pkgrel=1
pkgdesc='Deepin widget of Chinese Lunar library'
arch=('any')
url="http://www.linuxdeepin.com/"
license=('GPL2')
depends=('deepin-pygtk' 'glib2' 'gdk-pixbuf2')
makedepends=('autogen' 'gobject-introspection' 'python2' 'python2-gobject2' 'pygobject2-devel' 'gtk-doc')

_fileurl=http://packages.linuxdeepin.com/deepin/pool/main/d/dtk-widget/dtk-widget_0.5+git20131206101523~8759cb0fb5.tar.gz
source=("${_fileurl}")
md5sums=('41b46cb3074a7721c02e1d03ea0b913e')

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
    env PYTHON="/usr/bin/python2" ./autogen.sh --prefix=/usr
    make clean
    make
}

package() {
    cd "${srcdir}/${_innerdir}"
    make DESTDIR="$pkgdir" install
	find "${pkgdir}" -name *.la -delete
    _install_copyright_and_changelog
}
