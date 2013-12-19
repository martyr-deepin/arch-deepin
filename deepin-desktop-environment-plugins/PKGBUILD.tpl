# Maintainer: Xu Fasheng <fasheng.xu@gmail.com>

pkgname=deepin-desktop-environment-plugins
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Plugins for Linux Deepin desktop environment'
arch=('i686' 'x86_64')
depends=('deepin-desktop-environment' 'deepin-artwork')
license=('Unknown')
provides=("${pkgname}")
conflicts=("${pkgname}-git")
url="http://www.linuxdeepin.com/"
_pkgsite="http://packages.linuxdeepin.com"
# _pkgsite="http://mirrors.ustc.edu.cn" # candidate server
_parent_url="${_pkgsite}/deepin/pool/main/d/${pkgname}"
source=("${_parent_url}/{% filename %}"
        "${_parent_url}/{% plugfile_1 %}"
        "${_parent_url}/{% plugfile_2 %}"
        )
md5sums=('{% md5 %}'
         '{% md5plug_1 %}'
         '{% md5plug_2 %}'
         )

package() {
    # extract *.deb
    cd ${srcdir}
    for f in $(ls -1 *.deb); do
        msg2 "Extracting ${f}"
        bsdtar -xvf ${f}
        bsdtar -xvf data.tar.gz -C ${pkgdir}/
    done
}
