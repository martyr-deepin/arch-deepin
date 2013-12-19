# This package is maintained by 'pkgbuildup', and will update weekly,
# if something wrong just notice me please.
# Maintainer: Xu Fasheng <fasheng.xu@gmail.com>

pkgname=deepin-webkit
pkgver={% pkgver %}
pkgrel=1
pkgdesc='A modified webkitgtk libirary for Linux Deepin'
arch=('i686' 'x86_64')
depends=('webkitgtk' 'icu48')
license=('LGPL + GPL + BSD + other')
provides=("${pkgname}")
conflicts=("${pkgname}-git")
url="http://www.linuxdeepin.com/"

_pkgsite="http://packages.linuxdeepin.com"
# _pkgsite="http://mirrors.ustc.edu.cn" # candidate server
_parent_url="${_pkgsite}/deepin/pool/main/d/${pkgname}"
_file_x86="{% filename_x86 %}"
_file_x64="{% filename_x64 %}"
_md5_x86="{% md5_x86 %}"
_md5_x64="{% md5_x64 %}"
if test "$CARCH" == i686; then
    _file=${_file_x86}
    _md5=${_md5_x86}
else
    _file=${_file_x64}
    _md5=${_md5_x64}
fi
source=("${_parent_url}/${_file}")
md5sums=("${_md5}")

package() {
    tar xzvf ${srcdir}/data.tar.gz -C ${pkgdir}/
}
