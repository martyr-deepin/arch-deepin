# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=python2-deepin-lunar
pkgver=0.3.2
pkgrel=1
pkgdesc='Python2 binds lunar library for gtk-2.0 from Linux Deepin'
arch=('any')
url="http://www.linuxdeepin.com/"
license=('GPL2')
depends=('libdtk-widget' 'python2-libdtk-widget' 'python2' 'python2-gobject2' 'glib2' 'deepin-pygtk' 'lunar-calendar2' 'lunar-date')

makedepends=('python2-setuptools' 'autogen')

_fileurl=http://packages.linuxdeepin.com/deepin/pool/main/p/python-deepin-lunar/python-deepin-lunar_0.3.2.orig.tar.gz
source=("${_fileurl}")
md5sums=('f6de0913246111c70ce5204fd6167298')

_innerdir="."

_install_copyright_and_changelog() {
    mkdir -p "${pkgdir}/usr/share/doc/${pkgname}"
    cp -f debian/copyright "${pkgdir}/usr/share/doc/${pkgname}/"
    gzip -c debian/changelog > "${pkgdir}/usr/share/doc/${pkgname}/changelog.gz"
}

package() {
    cd "${srcdir}/${_innerdir}"

    # fix setup.py
    sed -i "s/libraries = .*$/libraries = ['glib-2.0', 'lunar-calendar-2.0', 'dltk-2.0'],/" setup.py

    python2 setup.py install --prefix=/usr --root="${pkgdir}"
    _install_copyright_and_changelog
}
