# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=deepin-screenshot
pkgver={% pkgver %}
pkgrel=1
pkgdesc="Provide a quite easy-to-use screenshot tool. Features:Global hotkey to triggle screenshot tool,Take screenshot of a selected area,Easy to add text and line drawings onto the screenshot"
arch=('any')
url="http://www.linuxdeepin.com/"
license=('LGPL3')
depends=('python2' 'gconf' 'python2-xlib' 'deepin-ui' 'python2-wnck' 'python2-xdg' 'python2-scipy' 'python2-pycurl')

source=("{% fileurl %}")
md5sums=('{% md5 %}')

package() {
    tar xzvf ${srcdir}/data.tar.gz -C ${pkgdir}/

    # fix python version
    find "${pkgdir}" -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python=\1python2='
}
