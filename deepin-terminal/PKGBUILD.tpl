# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=deepin-terminal
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Awesome terminal for Linux Deepin'
arch=('any')
url="http://www.linuxdeepin.com/"
license=('GPL2')
depends=('deepin-ui' 'deepin-vte-plus' 'python2-dbus')

source=("{% fileurl %}")
md5sums=('{% md5 %}')

package() {
    tar xzvf ${srcdir}/data.tar.gz -C ${pkgdir}/

    # fix python version
    find "${pkgdir}" -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python=\1python2='

    # there is no 'XHei' font on archinux, so replace it
    sed -i 's/XHei Mono.Ubuntu/Monospace/' ${pkgdir}/usr/share/deepin-terminal/src/main.py
}
