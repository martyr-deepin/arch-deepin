# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=python2-deepin-pulseaudio
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Pulseaudio python2 binding for deepin-system-setting'
arch=('any')
url="http://www.linuxdeepin.com/"
license=('GPL2')
depends=('python2' 'libpulse')
makedepends=('python2-setuptools')

_fileurl={% fileurl %}
source=("${_fileurl}")
md5sums=('{% md5 %}')

_filename="$(basename "${_fileurl}")"
_filename="${_filename%-*}"
_innerdir="${_filename/_/-}"

_install_copyright_and_changelog() {
    mkdir -p "${pkgdir}/usr/share/doc/${pkgname}"
    cp -f debian/copyright "${pkgdir}/usr/share/doc/${pkgname}/"
    gzip -c debian/changelog > "${pkgdir}/usr/share/doc/${pkgname}/changelog.gz"
}

package() {
    cd "${srcdir}/${_innerdir}"

    python2 setup.py install --root="${pkgdir}"
    _install_copyright_and_changelog
}
