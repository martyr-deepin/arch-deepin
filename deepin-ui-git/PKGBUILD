# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>
# Contributor: hexchain <i [at] hexchain [dot] com>

pkgname=deepin-ui-git
pkgver=20131210
pkgrel=1
pkgdesc="UI for Linux Deepin - git version"
arch=("i686" "x86_64")
url="https://github.com/linuxdeepin/deepin-ui/"
license=("GPL3")
depends=('deepin-utils' 'deepin-gsettings' 'glib2' 'libsoup' 'deepin-pygtk')
makedepends=('git' 'python2-distribute')
provides=('deepin-ui')
conflicts=('deepin-ui')

_gitroot="git://github.com/linuxdeepin/deepin-ui.git"
_gitname="deepin-ui"

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

    rm -rf "$srcdir/${_gitname}-build"
    cp -r "$srcdir/${_gitname}" "$srcdir/${_gitname}-build"
    cd "$srcdir/${_gitname}-build"
    rm -rf *.deb

    find . -name "*.py" | xargs sed -i -re "s/python?/python2/"
    # I have no idea why Deepin guys print out the results...
    sed -i -e "s/print\ results/#print\ results/" setup.py
    python2 setup.py build
}

package() {
    cd "$srcdir/${_gitname}-build"
    python2 setup.py install --root="$pkgdir/" --optimize=1
    mv "$pkgdir/usr/dtk/theme" "$pkgdir/usr/lib/python2.7/site-packages/dtk/"
    rm -rf "$pkgdir/usr/dtk"

    # copy demos
    mkdir -p "$pkgdir/usr/share/dtk/demos"
    for i in demo browser_demo fullscreen_demo mplayer_demo; do
        install -D "$srcdir/${_gitname}-build/$i.py" "$pkgdir/usr/share/dtk/demos/"
    done
}

# vim: set et ts=4 sw=4 sts=4:
