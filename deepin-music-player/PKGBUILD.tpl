# Maintainer: Xu Fasheng <fasheng.xu@gmail.com>

pkgname=deepin-music-player
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Awesome music player with brilliant and tweakful UI Deepin-UI based, gstreamer front-end, with features likes search music by pinyin,quanpin, colorful lyrics supports, and more powerfull functions you will found.'
depends=('gstreamer0.10-python' 'gstreamer0.10-bad-plugins' 'gstreamer0.10-good-plugins' 'gstreamer0.10-ugly-plugins' 'mutagen' 'python2-chardet' 'python2-scipy' 'python2-pyquery' 'python2-cssselect' 'deepin-ui' 'python2-dbus' 'sonata' 'cddb-py' 'python2-pycurl' 'python-xlib' 'python2-keybinder2')
arch=('any')
provides=("${pkgname}")
conflicts=("${pkgname}-git")
url="http://www.linuxdeepin.com/"
license=('GPL-3')
_pkgsite="http://packages.linuxdeepin.com"
# _pkgsite="http://mirrors.ustc.edu.cn" # candidate server
_parent_url="${_pkgsite}/deepin/pool/main/d/${pkgname}"
source=("${_parent_url}/{% filename %}")
md5sums=('{% md5 %}')

package() {
    tar xzvf ${srcdir}/data.tar.gz -C ${pkgdir}/

    # fix python version
    find ${pkgdir} -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python=\1python2='

    cd ${pkgdir}/usr/share/deepin-music-player/tools
    python2 generate_mo.py
}
