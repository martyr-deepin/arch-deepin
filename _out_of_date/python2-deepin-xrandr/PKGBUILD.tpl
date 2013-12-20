# Maintainer: Xu Fasheng <fasheng.xu@gmail.com>

pkgname=python2-deepin-xrandr
pkgver={% pkgver %}
pkgrel=1
pkgdesc='XRandR Python2 Binding from Linux Deepin'
arch=('any')
depends=('python2' 'glib2' 'libxrandr')
makedepends=('python2-setuptools')
license=('GPL2')
provides=("${pkgname}")
conflicts=("${pkgname}-git")
url="http://www.linuxdeepin.com/"

_pkgsite="http://packages.linuxdeepin.com"
# _pkgsite="http://mirrors.ustc.edu.cn" # candidate server
_parent_url="${_pkgsite}/deepin/pool/main/d/deepin-xrandr"
source=("${_parent_url}/{% filename %}")
md5sums=('{% md5 %}')

package() {
    cd "deepin-xrandr-0.1+${pkgver}"
    python2 setup.py install --prefix=/usr --root="${pkgdir}"
}
