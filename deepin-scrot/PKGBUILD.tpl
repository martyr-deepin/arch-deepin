# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>
# Contributor: crazyelf5

pkgname=deepin-scrot
pkgver={% pkgver %}
pkgrel=1
pkgdesc="A screenshot tool with Linux Deepin modifications"
arch=('any')
url="http://www.linuxdeepin.com/"
license=('LGPL3')
depends=('gconf' 'pygtk' 'python-xlib' 'python2')

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

package() {
    cd lovesnow*

    # fix python version
    find -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python=\1python2='

    sed -i 's|locale/|../../pkg/deepin-scrot/usr/share/deepin-scrot/locale/|' ./updateTranslate.sh

    ./updateTranslate.sh

    install -dm755 "${pkgdir}"/usr/{bin,share/{${pkgname},doc/${pkgname}}}
    cp -rf src theme "${pkgdir}/usr/share/${pkgname}/"

    chmod +x "${pkgdir}/usr/share/${pkgname}/src/deepinScrot.py"

    ln -fs /usr/share/${pkgname}/src/${pkgname} "${pkgdir}/usr/bin/${pkgname}"

    _install_copyright_and_changelog
}
