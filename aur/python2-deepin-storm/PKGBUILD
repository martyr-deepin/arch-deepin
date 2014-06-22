# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>
# Contributor: Josip Ponjavic <josipponjavic at gmail dot com>

pkgname=python2-deepin-storm
pkgver=git20131206101931
pkgrel=1
arch=('any')
url="http://linuxdeepin.com/"
license=('GPL3')
pkgdesc="Python Storm is download library and tool for Linux Deepin project."
depends=('python2' 'python2-gevent')
makedepends=('python2-setuptools' 'intltool')

_fileurl=http://packages.linuxdeepin.com/deepin/pool/main/p/pystorm//pystorm_0.1+git20131206101931~ade21bf585.tar.gz
source=("${_fileurl}")
md5sums=('4e038798f241ec19620ab48a7d5ac7ec')

_filename="$(basename "${_fileurl}")"
_filename="${_filename%.tar.gz}"
_innerdir="${_filename/_/-}"

_install_copyright_and_changelog() {
    mkdir -p "${pkgdir}/usr/share/doc/${pkgname}"
    cp -f debian/copyright "${pkgdir}/usr/share/doc/${pkgname}/"
    gzip -c debian/changelog > "${pkgdir}/usr/share/doc/${pkgname}/changelog.gz"
}

prepare() {
    cd "${srcdir}/${_innerdir}"

    # fix python version
    find -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python=\1python2='
}

package() {
    cd "${srcdir}/${_innerdir}"
    python2 setup.py install --root="${pkgdir}"
    _install_copyright_and_changelog
}
