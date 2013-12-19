# This package is maintained by 'pkgbuildup', and will update weekly,
# if something wrong just notice me please.
# Maintainer: Xu Fasheng <fasheng.xu@gmail.com>

pkgname=deepin-artwork
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Artworks package for Linux Deepin'
arch=('i686' 'x86_64')
depends=('deepin-icon-theme' 'deepin-gtk-theme' 'wqy-microhei')
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
