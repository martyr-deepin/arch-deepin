# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=('deepin-desktop-environment-plugins'
         'deepin-desktop-environment-plugins-clock'
         'deepin-desktop-environment-plugins-weather')
pkgbase='deepin-desktop-environment-plugins'
pkgver={% pkgver %}
pkgrel=1
arch=('any')
url="http://www.linuxdeepin.com/"
license=('GPL2')
makedepends=('coffee-script')

_fileurl={% fileurl %}
source=("${_fileurl}")
md5sums=('{% md5 %}')

_filename="$(basename "${_fileurl}")"
_filename="${_filename%.tar.gz}"
_innerdir="${_filename/_/-}"

_install_copyright_and_changelog() {
    local pkgname=$1
    mkdir -p "${pkgdir}/usr/share/doc/${pkgname}"
    cp -f debian/copyright "${pkgdir}/usr/share/doc/${pkgname}/"
    gzip -c debian/changelog > "${pkgdir}/usr/share/doc/${pkgname}/changelog.gz"
}

package_deepin-desktop-environment-plugins() {
    depends=('deepin-desktop-environment-plugins-clock' 'deepin-desktop-environment-plugins-weather')
    pkgdesc='Meta package for Linux Deepin desktop environment plugins'

    cd "${srcdir}/${_innerdir}"
    _install_copyright_and_changelog "${pkgname}"
}

package_deepin-desktop-environment-plugins-clock() {
    depends=('deepin-artwork' 'deepin-desktop-environment-common')
    pkgdesc='Linux Deepin desktop environment clock plugin'

    cd "${srcdir}/${_innerdir}"

    (cd clock; make)

    find clock \( -name "*.coffee" -or -name "makefile" \) -delete
    mkdir -p "${pkgdir}"/usr/share/dde/resources/desktop/plugin
    cp -R clock "${pkgdir}"/usr/share/dde/resources/desktop/plugin/

    _install_copyright_and_changelog "${pkgname}"
}

package_deepin-desktop-environment-plugins-weather() {
    depends=('deepin-artwork' 'deepin-desktop-environment-common')
    pkgdesc='Linux Deepin desktop environment weather plugin'

    cd "${srcdir}/${_innerdir}"

    (cd weather; make)
    find weather \( -name "*.coffee" -or -name "makefile" \) -delete

    mkdir -p "${pkgdir}"/usr/share/dde/resources/desktop/plugin
    cp -R weather "${pkgdir}"/usr/share/dde/resources/desktop/plugin

    _install_copyright_and_changelog "${pkgname}"
}
