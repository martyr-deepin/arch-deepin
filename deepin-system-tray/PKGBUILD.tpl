# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=deepin-system-tray
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Icon theme from Linux Deepin'
arch=('i686' 'x86_64')
url="http://www.linuxdeepin.com/"
license=('GPL2')
depends=('deepin-system-settings')

source=("{% fileurl %}")
md5sums=('{% md5 %}')

package() {
    tar xzvf ${srcdir}/data.tar.gz -C ${pkgdir}/

    # fix python version
    find ${pkgdir} -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python=\1python2='
}
