# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=deepin-default-gsettings
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Default gsettings schemas for Linux Deepin'
arch=('any')
url="http://www.linuxdeepin.com/"
license=('GPL2')
depends=()
install="${pkgname}.install"

_fileurl={% fileurl %}
source=("${_fileurl}")
md5sums=('{% md5 %}')

_innerdir="${pkgname}-0.1"

_install_copyright_and_changelog() {
    mkdir -p "${pkgdir}/usr/share/doc/${pkgname}"
    cp -f debian/copyright "${pkgdir}/usr/share/doc/${pkgname}/"
    gzip -c debian/changelog > "${pkgdir}/usr/share/doc/${pkgname}/changelog.gz"
}

package() {
    cd "${srcdir}/${_innerdir}"

	(for f in *.override; do cat $f; done) > tmp_all_schemas
    mv tmp_all_schemas 99_deepin-default-gsettings.gschema.override
    install -dm755 "${pkgdir}"/usr/share/glib-2.0/schemas/
    install -m644 99_deepin-default-gsettings.gschema.override "${pkgdir}"/usr/share/glib-2.0/schemas/

    _install_copyright_and_changelog
}
