# Maintainer: Xu Fasheng <fasheng.xu@gmail.com>

pkgname=deepin-terminal
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Awesome terminal for Linux Deepin'
arch=('i686' 'x86_64')
depends=('deepin-ui' 'deepin-vte-plus' 'python2-dbus')
license=('GPL2')
provides=("${pkgname}")
conflicts=("${pkgname}-git")
url="http://www.linuxdeepin.com/"
_pkgsite="http://packages.linuxdeepin.com"
# _pkgsite="http://mirrors.ustc.edu.cn" # candidate server
_parent_url="${_pkgsite}/deepin/pool/main/d/${pkgname}"
source=("${_parent_url}/{% filename %}")
md5sums=('{% md5 %}')

package() {
    tar xzvf ${srcdir}/data.tar.gz -C ${pkgdir}/

    # fix python version
    find ${pkgdir} -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python=\1python2='

    # there is no 'XHei' font on archinux, so replace it
    sed -i 's/XHei Mono.Ubuntu/Monospace/' ${pkgdir}/usr/share/deepin-terminal/src/main.py
}
