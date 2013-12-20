# Maintainer: Xu Fasheng <fasheng.xu@gmail.com>

pkgname=deepin-artwork
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Artworks package for Linux Deepin'
arch=('i686' 'x86_64')
license=('LGPL3')
url="http://www.linuxdeepin.com/"
depends=('deepin-icon-theme' 'deepin-gtk-theme' 'wqy-microhei')
provides=("${pkgname}")
conflicts=("${pkgname}-git")

_pkgsite="http://packages.linuxdeepin.com"
# _pkgsite="http://mirrors.ustc.edu.cn" # candidate server
_parent_url="${_pkgsite}/deepin/pool/main/d/${pkgname}"
source=("${_parent_url}/{% filename %}")
md5sums=('{% md5 %}')

package() {
    cd "${srcdir}/${pkgname}-${pkgver}"

    install -m755 -d "${pkgdir}/usr/share/pixmaps"
    cp -R usr/share/pixmaps ${pkgdir}/usr/share/pixmaps/

    install -m755 -d "${pkgdir}/usr/share/sounds"
    cp -R usr/share/sounds ${pkgdir}/usr/share/sounds/
}
