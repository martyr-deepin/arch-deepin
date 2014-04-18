# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname='python2-libdtk-widget'
pkgver=git20131206101523
pkgrel=1
pkgdesc='Python2 binds for Deepin widget of Chinese Lunar library'
arch=('any')
url="http://www.linuxdeepin.com/"
license=('GPL2')
depends=('python2' 'libdtk-widget')
makedepends=('python2-setuptools' 'python2-gobject2' 'pygobject2-devel')

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

package() {
    cd "${srcdir}/${_innerdir}"
	python2 setup.py install --prefix=/usr --root "${pkgdir}"
    _install_copyright_and_changelog
}
