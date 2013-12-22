# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=deepin-artwork
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Artworks package for Linux Deepin'
arch=('i686' 'x86_64')
license=('LGPL3')
url="http://www.linuxdeepin.com/"
depends=('deepin-icon-theme' 'deepin-gtk-theme' 'wqy-microhei')

_fileurl={% fileurl %}
source=("${_fileurl}")
md5sums=('{% md5 %}')

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

    mkdir -p "${pkgdir}"/usr/share/pixmaps
    cp -R usr/share/pixmaps "${pkgdir}"/usr/share/pixmaps/

    mkdir -p "${pkgdir}"/usr/share/sounds
    cp -R usr/share/sounds "${pkgdir}"/usr/share/sounds/

    _install_copyright_and_changelog
}
