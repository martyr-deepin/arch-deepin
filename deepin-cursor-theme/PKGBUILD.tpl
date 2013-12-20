# Maintainer: Xu Fasheng <fasheng.xu@gmail.com>

pkgname=deepin-cursor-theme
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Cursor theme from Linux Deepin'
arch=('i686' 'x86_64')
license=('LGPL3')
url="http://www.linuxdeepin.com/"
provides=("${pkgname}")
conflicts=("${pkgname}-git")

_pkgsite="http://packages.linuxdeepin.com"
# _pkgsite="http://mirrors.ustc.edu.cn" # candidate server
_parent_url="${_pkgsite}/deepin/pool/main/d/${pkgname}"
source=("${_parent_url}/{% filename %}")
md5sums=('{% md5 %}')

package() {
    cd "${srcdir}/${pkgname}-${pkgver}"
    install -m755 -d "${pkgdir}/usr/share/icons"
    cp -R Deepin-Cursor "${pkgdir}/usr/share/icons/"
}
