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

_pkgsite="http://packages.linuxdeepin.com"
# _pkgsite="http://mirrors.ustc.edu.cn" # candidate server
_parent_url="${_pkgsite}/deepin/pool/main/d/deepin-wallpapers"
source=("${_parent_url}/{% filename %}")
md5sums=('{% md5 %}')

package_deepin-default-wallpapers() {

}

package_deepin-extra-wallpapers() {

}
