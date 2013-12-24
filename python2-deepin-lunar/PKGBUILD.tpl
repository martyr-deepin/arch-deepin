# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=python2-deepin-lunar
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Python2 binds lunar library for gtk-2.0 from Linux Deepin'
arch=('any')
url="http://www.linuxdeepin.com/"
license=('GPL2')
depends=('libdtk-widget' 'python2-libdtk-widget' 'python2' 'python2-gobject2' 'glib2' 'deepin-pygtk-fix' 'lunar-calendar2' 'lunar-date')

makedepends=('python2-setuptools' 'autogen')

_fileurl={% fileurl %}
source=("${_fileurl}")
md5sums=('{% md5 %}')

_innerdir="."

_install_copyright_and_changelog() {
    mkdir -p "${pkgdir}/usr/share/doc/${pkgname}"
    cp -f debian/copyright "${pkgdir}/usr/share/doc/${pkgname}/"
    gzip -c debian/changelog > "${pkgdir}/usr/share/doc/${pkgname}/changelog.gz"
}

package() {
    cd "${srcdir}/${_innerdir}"
    python2 setup.py install --prefix=/usr --root="${pkgdir}"
    _install_copyright_and_changelog
}
