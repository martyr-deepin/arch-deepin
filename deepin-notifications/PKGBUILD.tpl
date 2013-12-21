# Maintainer: Xu Fasheng <fasheng.xu@gmail.com>

pkgname=deepin-notifications
pkgver={% pkgver %}
pkgrel=1
pkgdesc='System notifications for Linux Deepin desktop environment'
arch=('i686' 'x86_64')
license=('GPL2')
url="http://www.linuxdeepin.com/"
depends=('deepin-ui' 'deepin-pygtk-fix' 'python2-dbus' 'python2-cairo')
conflicts=("notify-osd")

_pkgsite="http://packages.linuxdeepin.com"
# _pkgsite="http://mirrors.ustc.edu.cn" # candidate server
_parent_url="${_pkgsite}/deepin/pool/main/d/${pkgname}"
source=("${_parent_url}/{% filename %}")
md5sums=('{% md5 %}')

package() {
    tar xzvf ${srcdir}/data.tar.gz -C ${pkgdir}/

    # fix python version
    find ${pkgdir} -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python=\1python2='
    sed -i 's=\(^#! */usr/bin.*\)python=\1python2=' ${pkgdir}/usr/bin/deepin-notify
}
