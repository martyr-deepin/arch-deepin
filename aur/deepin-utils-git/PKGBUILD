# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=deepin-utils-git
pkgver=20140706.ec7da4a
pkgrel=1
pkgdesc='Utils of DeepinUI Toolkit modules - git version'
arch=("i686" "x86_64")
url="https://gitcafe.com/Deepin/deepin-utils/"
license=("GPL3")
depends=('python2' 'pygtk' 'python2-cairo' 'python2-imaging' 'libwebkit' 'python2-xlib' 'pywebkitgtk')
provides=('deepin-utils')
conflicts=('deepin-utils')

_gitroot="git://gitcafe.com/Deepin/deepin-utils.git"
_gitname="deepin-utils"

build() {
    cd "$srcdir"
    msg "Connecting to GIT server..."

    if [[ -d "$_gitname" ]]; then
        cd "$_gitname" && git pull origin
        msg "The local files are updated."
    else
        git clone "$_gitroot" "$_gitname" --depth 1
    fi

    msg "GIT checkout done or server timeout"
    msg "Starting build..."

    cd "$srcdir/${_gitname}"
    python2 setup.py build
}

package() {
    cd "$srcdir/${_gitname}"
    python2 setup.py install --root="$pkgdir/" --optimize=1

    cd ${pkgdir}/usr/lib/python2.7/site-packages/deepin_utils/
    sed -i 's_#! /usr/bin/env python$_#! /usr/bin/env python2_' *.py
}

# vim: set et ts=4 sw=4 sts=4:
