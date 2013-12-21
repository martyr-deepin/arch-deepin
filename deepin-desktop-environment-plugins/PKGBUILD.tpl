# Maintainer: Xu Fasheng <fasheng.xu@gmail.com>

pkgname=deepin-desktop-environment-plugins
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Plugins for Linux Deepin desktop environment'
arch=('i686' 'x86_64')
url="http://www.linuxdeepin.com/"
license=('GPL2')
depends=('deepin-desktop-environment' 'deepin-artwork')

source=("{% fileurl_1 %}"
        "{% fileurl_2 %}"
        "{% fileurl_3 %}")
md5sums=('{% md5_1 %}'
         '{% md5_2 %}'
         '{% md5_3 %}')

package() {
    # extract *.deb
    cd ${srcdir}
    for f in $(ls -1 *.deb); do
        msg2 "Extracting ${f}"
        bsdtar -xvf ${f}
        bsdtar -xvf data.tar.gz -C ${pkgdir}/
    done
}
