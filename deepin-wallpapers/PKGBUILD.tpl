# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

### MERGE TO ONE PACKAGE FOR AUR
# pkgname=('deepin-default-wallpapers'
         # 'deepin-extra-wallpapers')
# pkgbase='deepin-wallpapers'
pkgver={% pkgver %}
_realver={% pkgrel %}+${pkgver}
pkgrel=1
arch=('any')
url="http://www.linuxdeepin.com/"
license=('Unknown')

_fileurl={% fileurl %}
source=("${_fileurl}")
md5sums=('{% md5 %}')

_filename="$(basename "${_fileurl}")"
_filename="${_filename%.tar.gz}"
_innerdir="${_filename/_/-}"

_install_copyright_and_changelog() {
    mkdir -p "${pkgdir}/usr/share/doc/${pkgname}"
    cp -f debian/copyright "${pkgdir}/usr/share/doc/${pkgname}/"
    gzip -c debian/changelog > "${pkgdir}/usr/share/doc/${pkgname}/changelog.gz"
}

package_deepin-default-wallpapers() {
    pkgdesc='Default wallpapers for Linux Deepin'
    depends=('deepin-system-settings-module-individuation')
    conflicts=('deepin-extra-wallpapers')

    cd "${srcdir}/${_innerdir}"

    mkdir -p "${pkgdir}"/usr/share/deepin-system-settings/modules/individuation/theme
    mkdir -p "${pkgdir}"/usr/share/deepin-system-settings/modules/individuation/backgrounds

    cp -R modules/individuation/backgrounds/default.jpg "${pkgdir}"/usr/share/deepin-system-settings/modules/individuation/backgrounds/
    cp -R modules/individuation/backgrounds/deepin/ "${pkgdir}"/usr/share/deepin-system-settings/modules/individuation/backgrounds/
    cp -R modules/individuation/theme/bird.ini "${pkgdir}"/usr/share/deepin-system-settings/modules/individuation/theme/
    cp -R modules/individuation/theme/default.ini "${pkgdir}"/usr/share/deepin-system-settings/modules/individuation/theme/
    cp -R modules/individuation/theme/nebula.ini "${pkgdir}"/usr/share/deepin-system-settings/modules/individuation/theme/

    _install_copyright_and_changelog
}

package_deepin-extra-wallpapers() {
    pkgdesc='Extra wallpapers for Linux Deepin'
    depends=('deepin-system-settings-module-individuation')
    conflicts=('deepin-default-wallpapers')

    cd "${srcdir}/${_innerdir}"

    mkdir -p "${pkgdir}"/usr/share/deepin-system-settings/modules/individuation

    cp -R modules/individuation/theme "${pkgdir}"/usr/share/deepin-system-settings/modules/individuation/

    rm "${pkgdir}"/usr/share/deepin-system-settings/modules/individuation/theme/bird.ini -f
    rm "${pkgdir}"/usr/share/deepin-system-settings/modules/individuation/theme/nebula.ini -f
    rm "${pkgdir}"/usr/share/deepin-system-settings/modules/individuation/theme/default.ini -f

    _install_copyright_and_changelog
}

### MERGE TO ONE PACKAGE FOR AUR
pkgname='deepin-default-wallpapers'
package() {
    package_deepin-default-wallpapers

    pkgdesc='Default wallpapers for Linux Deepin'
    depends=('deepin-system-settings')
}
