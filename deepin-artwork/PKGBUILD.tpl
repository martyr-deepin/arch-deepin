# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=deepin-artwork
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Artworks package for Linux Deepin'
arch=('i686' 'x86_64')
license=('LGPL3')
url="http://www.linuxdeepin.com/"
depends=('deepin-icon-theme' 'deepin-gtk-theme' 'wqy-microhei')

source=("{% fileurl %}")
md5sums=('{% md5 %}')

package() {
    cd "${srcdir}/${pkgname}-${pkgver}"

    mkdir -p "${pkgdir}"/usr/share/pixmaps
    cp -R usr/share/pixmaps "${pkgdir}"/usr/share/pixmaps/

    mkdir -p "${pkgdir}"/usr/share/sounds
    cp -R usr/share/sounds "${pkgdir}"/usr/share/sounds/
}
