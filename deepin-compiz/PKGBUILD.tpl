# Maintainer: Xu Fasheng <fasheng.xu@gmail.com>

pkgname=deepin-compiz
pkgver={% pkgver %}
pkgrel=1
pkgdesc='A modified compiz for Linux Deepin'
arch=('i686' 'x86_64')
depends=()
license=('GPL2 + LGPL2.1 + MIT/X11')
provides=("${pkgname}" "compiz" "compiz-core=0.9.99" \
          "compiz-decorator-gtk" "ccsm" "compiz-fusion-plugins-main" \
          "compiz-fusion-plugins-extra" "libcompizconfig" \
          "compizconfig-python")
conflicts=("${pkgname}-git" "compiz" "compiz-core" \ 
          "compiz-decorator-gtk" "ccsm" "compiz-fusion-plugins-main" \
          "compiz-fusion-plugins-extra" "libcompizconfig" \
          "compizconfig-python")
url="http://www.linuxdeepin.com/"

_pkgsite="http://packages.linuxdeepin.com"
# _pkgsite="http://mirrors.ustc.edu.cn" # candidate server
_parent_url="${_pkgsite}/deepin/pool/main/c/compiz"
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
