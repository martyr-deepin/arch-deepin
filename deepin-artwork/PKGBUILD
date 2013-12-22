# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=deepin-artwork
pkgver=13.06.15
pkgrel=1
pkgdesc='Artworks package for Linux Deepin'
arch=('i686' 'x86_64')
license=('LGPL3')
url="http://www.linuxdeepin.com/"
depends=('deepin-icon-theme' 'deepin-gtk-theme' 'wqy-microhei')

_fileurl=http://packages.linuxdeepin.com/deepin/pool/main/d/deepin-artwork/deepin-artwork_13.06.15.tar.gz
source=("${_fileurl}")
md5sums=('03372c11f42f3faa858c1334de8f650d')

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
