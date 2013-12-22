# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>
# Maintainer: 4679kun <admin[AT]4679.us>
# Maintainer: dongfengweixiao <dongfengweixiao[AT]gmail.com>

pkgname=deepin-ui
pkgver={% pkgver %}
pkgrel=1
pkgdesc='UI toolkit for Linux Deepin'
arch=('i686' 'x86_64')
url="http://www.linuxdeepin.com/"
license=('GPL3')
depends=('deepin-utils' 'deepin-gsettings' 'deepin-pygtk-fix' 'python2-distribute' 'python2' 'glib2' 'python2-cairo' 'python2-imaging' 'libwebkit' 'python-xlib' 'pywebkitgtk' 'libsoup')

_fileurl={% fileurl %}
source=("${_fileurl}")
md5sums=('{% md5 %}')

_filename="$(basename "${_fileurl}")"
_filename="${_filename%.tar.gz}"
_innerdir="${_filename/_/-}"

build(){
    cd "${srcdir}/${_innerdir}"
    python2 setup.py build
}

package() {
    cd "${srcdir}/${_innerdir}"
    mkdir -p "$pkgdir"/usr/share/locale
    mkdir -p "$pkgdir"/usr/lib/python2.7/site-packages/dtk/theme
    python2 setup.py install --root="$pkgdir/" --optimize=1
    mv "$pkgdir"/usr/dtk/locale "$pkgdir"/usr/share/
    mv "$pkgdir"/usr/dtk/theme "$pkgdir"/usr/lib/python2.7/site-packages/dtk/
    rm -rf "$pkgdir"/usr/dtk/

    # fix python version
    find "${pkgdir}" -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python=\1python2='
}
