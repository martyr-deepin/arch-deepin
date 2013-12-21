# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=deepin-icon-theme
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Icon theme from Linux Deepin'
arch=('i686' 'x86_64')
depends=('faenza-icon-theme' 'deepin-cursor-theme')
license=('LGPL3')
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
}
