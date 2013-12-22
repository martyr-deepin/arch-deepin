# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>
# Maintainer: 4679kun <admin[AT]4679.us>
# Maintainer: dongfengweixiao <dongfengweixiao[AT]gmail.com>

pkgname=deepin-music-player
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Awesome music player with brilliant and tweakful UI Deepin-UI based, gstreamer front-end, with features likes search music by pinyin,quanpin, colorful lyrics supports, and more powerfull functions you will found.'
arch=('any')
url="http://www.linuxdeepin.com/"
license=('GPL3')
depends=('gstreamer0.10-python' 'gstreamer0.10-bad-plugins' 'gstreamer0.10-good-plugins' 'gstreamer0.10-ugly-plugins' 'mutagen' 'python2-chardet' 'python2-scipy' 'python2-pyquery' 'python2-cssselect' 'deepin-ui' 'python2-dbus' 'sonata' 'cddb-py' 'python2-pycurl' 'python-xlib' 'python2-keybinder2')

source=("{% fileurl %}")
md5sums=('{% md5 %}')

_innerdir="${pkgname}-1+${pkgver}"

_install_copyright_and_changelog() {
    local pkgname=$1
    mkdir -p "${pkgdir}"/usr/share/doc/${pkgname}
    cp -f debian/copyright "${pkgdir}"/usr/share/doc/${pkgname}/
    gzip -c debian/changelog > "${pkgdir}"/usr/share/doc/${pkgname}/changelog.gz
}

# Usage: _easycp dest files...
_easycp () {
    local dest=$1; shift
    mkdir -p "${dest}"
    cp -vR -t "${dest}" "$@"
}

package() {
    # tar xzvf ${srcdir}/data.tar.gz -C ${pkgdir}/

    # fix python version
    find "${pkgdir}" -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python=\1python2='

    cd ${pkgdir}/usr/share/deepin-music-player/tools
    python2 generate_mo.py
}
