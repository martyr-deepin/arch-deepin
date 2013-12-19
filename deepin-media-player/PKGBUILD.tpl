# Maintainer: Xu Fasheng <fasheng.xu@gmail.com>
# Maintainer: dongfengweixiao <dongfengweixiao[AT]gmail.com>

pkgname=deepin-media-player
pkgver={% pkgver %}
pkgrel=1
pkgdesc='New multimedia player with brilliant and tweakful UI. PyGtk and Deepin-ui Mplayer2 front-end, with features likes smplayer, but has a brilliant and tweakful UI.'
depends=('python2-scipy' 'python2-pyquery' 'deepin-ui' 'mplayer2' 'gstreamer0.10-ugly' 'gstreamer0.10-ugly-plugins' 'python2-formencode' 'gstreamer0.10-python' 'python2-chardet' 'python2-beautifulsoup3' 'python2-notify' 'python2-dbus' 'python2-xlib' )
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
}
