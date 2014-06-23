# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=grub-themes-deepin
pkgver=0.1
pkgrel=1
pkgdesc='Grub2 themes from Linux Deepin'
arch=('any')
url="http://www.linuxdeepin.com/"
license=('GPL2')
depends=('grub')

_fileurl={% fileurl %}
source=("${_fileurl}")
md5sums=('{% md5 %}')

_install_copyright_and_changelog() {
    mkdir -p "${pkgdir}/usr/share/doc/${pkgname}"
    cp -f debian/copyright "${pkgdir}/usr/share/doc/${pkgname}/"
    gzip -c debian/changelog > "${pkgdir}/usr/share/doc/${pkgname}/changelog.gz"
}

package() {
    cd "${srcdir}"

    cp -rf boot "${pkgdir}"

    _install_copyright_and_changelog
}
