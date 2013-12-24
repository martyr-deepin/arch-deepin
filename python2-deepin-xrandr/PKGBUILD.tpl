# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=python2-deepin-xrandr
pkgver={% pkgver %}
pkgrel=1
pkgdesc='XRandR Python2 Binding from Linux Deepin'
arch=('any')
url="http://www.linuxdeepin.com/"
license=('GPL2')
depends=('python2' 'glib2' 'libxrandr')
makedepends=('python2-setuptools')

_fileurl={% fileurl %}
source=("${_fileurl}")
md5sums=('{% md5 %}')

_filename="$(basename "${_fileurl}")"
_filename="${_filename%.tar.gz}"
_innerdir="${_filename/_/-}"

prepare() {
    cd "${srcdir}/${_innerdir}"

    # fix python version
    find -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python=\1python2='
}

package() {
    cd "${srcdir}/${_innerdir}"
    python2 setup.py install --prefix=/usr --root="${pkgdir}"
}
