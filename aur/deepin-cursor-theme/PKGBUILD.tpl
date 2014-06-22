# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=deepin-cursor-theme
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Cursor theme from Linux Deepin'
arch=('i686' 'x86_64')
license=('LGPL3')
url="http://www.linuxdeepin.com/"

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

    mkdir -p "${pkgdir}"/usr/share/icons
    cp -R Deepin-Cursor "${pkgdir}"/usr/share/icons/

    _install_copyright_and_changelog
}
