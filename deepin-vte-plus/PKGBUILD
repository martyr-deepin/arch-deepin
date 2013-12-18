# Maintainer: Xu Fasheng <fasheng.xu@gmail.com>

pkgname=deepin-vte-plus
_pkgname=vte
pkgver=0.28.2
pkgrel=6
pkgdesc="Virtual Terminal Emulator widget for use with GTK2 - with several patches"
arch=('i686' 'x86_64')
license=('GPL3')
options=('!libtool' '!emptydirs')
depends=('gtk2')
makedepends=('pygtk' 'intltool' 'gobject-introspection' 'pygobject2-devel')
url="https://developer.gnome.org/vte/"
patchsite="http://packages.linuxdeepin.com"
# patchsite="http://mirrors.ustc.edu.cn"
source=(http://ftp.gnome.org/pub/GNOME/sources/vte/0.28/vte-$pkgver.tar.xz
        ${patchsite}/deepin/pool/main/v/vte/vte_0.28.2-6deepin6.debian.tar.gz)
md5sums=('497f26e457308649e6ece32b3bb142ff'
         '55a179adbb01e0060981eb22294e015c')
provides=('vte=0.28.2')
conflicts=('vte')

build() {
    #unzip patches
    cd "$srcdir/"
    tar -xf vte_0.28.2-6deepin6.debian.tar.gz
    
    cd "$_pkgname-$pkgver"

    #apply patches
    patchdir=$srcdir/debian/patches
    for f in `cat $patchdir/series`; do
        echo "==> patching: ${f##*/}"
        # ignore error if patch again
        patch -Np1 -i $patchdir/$f || echo '==> patch error: ${f##*/}'
    done
    
    #warning: type-punning to incomplete type might break strict-aliasing rules
    export CFLAGS="$CFLAGS -fno-strict-aliasing"
    export PYTHON="/usr/bin/python2"
    ./configure --prefix=/usr --sysconfdir=/etc \
        --libexecdir=/usr/lib/vte \
        --localstatedir=/var --disable-static \
        --enable-introspection --with-gtk=2.0
    make
}

package(){
    cd "$srcdir/$_pkgname-$pkgver"
    make DESTDIR="$pkgdir" install
    rm -f "$pkgdir/usr/lib/vte/gnome-pty-helper"
}
