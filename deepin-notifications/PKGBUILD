# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=deepin-notifications
pkgver=git20140709141546
pkgrel=1
pkgdesc='System notifications for Linux Deepin desktop environment'
arch=('i686' 'x86_64')
license=('GPL2')
url="http://www.linuxdeepin.com/"
depends=('deepin-ui' 'deepin-pygtk' 'python2-dbus' 'python2-cairo')
conflicts=("notify-osd")

_fileurl=http://packages.linuxdeepin.com/deepin/pool/main/d/deepin-notifications/deepin-notifications_0.3+20140709141546~3d015c3452.tar.gz
source=("${_fileurl}")
md5sums=('9bd2e6ee765a6819c796e155d4ce6ecf')

_filename="$(basename "${_fileurl}")"
_filename="${_filename%-*}"
_innerdir="${_filename/_/-}"

_install_copyright_and_changelog() {
    mkdir -p "${pkgdir}/usr/share/doc/${pkgname}"
    cp -f debian/copyright "${pkgdir}/usr/share/doc/${pkgname}/"
    gzip -c debian/changelog > "${pkgdir}/usr/share/doc/${pkgname}/changelog.gz"
}

# Usage: _easycp dest files...
_easycp () {
    local dest=$1; shift
    mkdir -p "${dest}"
    cp -R -t "${dest}" "$@"
}

package() {
    cd "${srcdir}/${_innerdir}"

    _easycp "${pkgdir}"/usr/share/dbus-1/ services
    _easycp "${pkgdir}"/usr/share/deepin-notifications/ data
    _easycp "${pkgdir}"/usr/share/deepin-notifications/ locale
    _easycp "${pkgdir}"/usr/share/deepin-notifications/ app_theme
    _easycp "${pkgdir}"/usr/share/deepin-notifications/ skin
    _easycp "${pkgdir}"/usr/share/deepin-notifications/ src
    _easycp "${pkgdir}"/usr/bin/ tools/deepin-notify

    _install_copyright_and_changelog

    # fix python version
    find "${pkgdir}" -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python=\1python2='
    sed -i 's=\(^#! */usr/bin.*\)python=\1python2=' "${pkgdir}"/usr/bin/deepin-notify
}
