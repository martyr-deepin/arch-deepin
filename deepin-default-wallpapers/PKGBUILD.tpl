# Maintainer: Xu Fasheng <fasheng.xu@gmail.com>

pkgname=('deepin-default-wallpapers'
         'deepin-extra-wallpapers')
pkgbase="deepin-system-settings"
pkgver={% pkgver %}
_realver={% pkgrel %}+${pkgver}
pkgrel=1
pkgdesc='Default wallpapers for Linux Deepin'
arch=('i686' 'x86_64')
url="http://www.linuxdeepin.com/"
license=('Unknown')
depends=('deepin-system-settings-module-individuation')

source=("{% fileurl %}")
md5sums=('{% md5 %}')

package_deepin-default-wallpapers() {
    echo TODO
}

package_deepin-extra-wallpapers() {
    echo TODO
}
