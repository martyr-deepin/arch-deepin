# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>
# Contributor: Josip Ponjavic <josipponjavic at gmail dot com>

pkgname=deepin-session
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Deepin desktop session'
arch=('any')
url="http://www.linuxdeepin.com/"
license=('GPL2')
depends=('gnome-session' 'gnome-settings-daemon')

_fileurl={% fileurl %}
source=("${_fileurl}")
md5sums=('{% md5 %}')

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
