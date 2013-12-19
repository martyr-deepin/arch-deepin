# Maintainer: Xu Fasheng <fasheng.xu@gmail.com>

pkgname=deepin-desktop-environment
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Desktop environment of Linux Deepin'
arch=('i686' 'x86_64')
depends=('compiz-core' 'ccsm' 'deepin-artwork' 'deepin-webkit'
    'deepin-system-settings' 'deepin-notifications' 'deepin-system-tray'
    'dbus-glib' 'glib2' 'gtk3' 'gstreamer0.10' 'lightdm' 'opencv' 'sqlite'
    'gvfs' 'xdg-user-dirs')
makedepends=('cmake' 'go' 'coffee-script')
license=('GPL2')
provides=("${pkgname}")
conflicts=("${pkgname}-git")
url="http://www.linuxdeepin.com/"
_pkgsite="http://packages.linuxdeepin.com"
# _pkgsite="http://mirrors.ustc.edu.cn" # candidate server
_parent_url="${_pkgsite}/deepin/pool/main/d/${pkgname}"
source=("${_parent_url}/{% filename %}")
md5sums=('{% md5 %}')

package() {
    _srcdir=`find ${srcdir} -maxdepth 1 -type d | tail -1`
    cd ${_srcdir}

    mkdir -p build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX="/usr" ..
    make
    make DESTDIR="${pkgdir}" install

    # fix python version
    find ${pkgdir} -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python=\1python2='

    # move 'shutdown' command to /usr/bin/deepin to resolve coflicts
    cd ${pkgdir}
    mkdir -p usr/bin/deepin
    mv usr/bin/shutdown usr/bin/deepin
}
