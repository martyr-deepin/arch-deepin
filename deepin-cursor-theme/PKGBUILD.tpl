# Maintainer: Xu Fasheng <fasheng.xu@gmail.com>

pkgname=deepin-cursor-theme
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Cursor theme from Linux Deepin'
arch=('i686' 'x86_64')
license=('LGPL3')
url="http://www.linuxdeepin.com/"

source=("{% fileurl %}")
md5sums=('{% md5 %}')

package() {
    cd "${srcdir}/${pkgname}-${pkgver}"
    mkdir -p "${pkgdir}"/usr/share/icons
    cp -R Deepin-Cursor "${pkgdir}"/usr/share/icons/
}
