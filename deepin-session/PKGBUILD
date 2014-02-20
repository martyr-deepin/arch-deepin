# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>
# Contributor: Josip Ponjavic <josipponjavic at gmail dot com>

pkgname=deepin-session
pkgver=2.0
pkgrel=1
pkgdesc='Deepin desktop session'
arch=('any')
url="http://www.linuxdeepin.com/"
license=('GPL2')
depends=('gnome-session' 'gnome-settings-daemon')

_fileurl=http://packages.linuxdeepin.com/deepin/pool/main/d/deepin-session/deepin-session_2.0-2.tar.gz
source=("${_fileurl}")
md5sums=('11cc1feb6c363d84c944e3b0d9c833ac')

_filename="$(basename "${_fileurl}")"
_filename="${_filename%-*.tar.gz}"
_innerdir="${_filename/_/-}"

_install_copyright_and_changelog() {
    mkdir -p "${pkgdir}/usr/share/doc/${pkgname}"
    cp -f debian/copyright "${pkgdir}/usr/share/doc/${pkgname}/"
    gzip -c debian/changelog > "${pkgdir}/usr/share/doc/${pkgname}/changelog.gz"
}

package() {
    cd "${srcdir}/${_innerdir}"

    mkdir -p "${pkgdir}"/usr/share/xsessions/
    mkdir -p "${pkgdir}"/usr/share/gnome-session/sessions/
    install -m 0644 debian/deepin.desktop "${pkgdir}"/usr/share/xsessions/
    install -m 0644 debian/deepin.session "${pkgdir}"/usr/share/gnome-session/sessions/

    _install_copyright_and_changelog
}
