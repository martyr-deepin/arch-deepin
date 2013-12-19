# Maintainer: Xu Fasheng <fasheng.xu@gmail.com>

pkgname=deepin-default-wallpapers
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Default wallpapers for Linux Deepin'
arch=('i686' 'x86_64')
depends=('deepin-system-settings')
license=('Unknown')
provides=("${pkgname}")
conflicts=("${pkgname}-git")
url="http://www.linuxdeepin.com/"
_pkgsite="http://packages.linuxdeepin.com"
# _pkgsite="http://mirrors.ustc.edu.cn" # candidate server
_parent_url="${_pkgsite}/deepin/pool/main/d/deepin-wallpapers"
source=("${_parent_url}/{% filename %}")
md5sums=('{% md5 %}')

package() {
    tar xzvf ${srcdir}/data.tar.gz -C ${pkgdir}/
}
