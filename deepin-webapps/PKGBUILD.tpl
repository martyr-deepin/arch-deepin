# Maintainer: Xu Fasheng <fasheng.xu@gmail.com>

pkgname=deepin-webapps
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Webapps from Deepin Linux'
arch=('i686' 'x86_64')
url="http://www.linuxdeepin.com/"
license=('Unknown')
depends=('chromium' 'xdg-utils')

source=(" fileurl_1 %}"
        " fileurl_2 %}"
        " fileurl_3 %}"
        " fileurl_4 %}"
        " fileurl_5 %}"
        " fileurl_6 %}"
        " fileurl_7 %}"
        " fileurl_8 %}"
        " fileurl_9 %}"
        " fileurl_10 %}"
        " fileurl_11 %}"
        " fileurl_12 %}"
        " fileurl_13 %}"
        " fileurl_14 %}"
        " fileurl_15 %}"
        " fileurl_16 %}"
        " fileurl_17 %}"
        " fileurl_18 %}"
        " fileurl_19 %}"
        " fileurl_20 %}"
        " fileurl_21 %}"
        " fileurl_22 %}"
        " fileurl_23 %}")
md5sums=('{% md5_1 %}'
         '{% md5_2 %}'
         '{% md5_3 %}'
         '{% md5_4 %}'
         '{% md5_5 %}'
         '{% md5_6 %}'
         '{% md5_7 %}'
         '{% md5_8 %}'
         '{% md5_9 %}'
         '{% md5_10 %}'
         '{% md5_11 %}'
         '{% md5_12 %}'
         '{% md5_13 %}'
         '{% md5_14 %}'
         '{% md5_15 %}'
         '{% md5_16 %}'
         '{% md5_17 %}'
         '{% md5_18 %}'
         '{% md5_19 %}'
         '{% md5_20 %}'
         '{% md5_21 %}'
         '{% md5_22 %}'
         '{% md5_23 %}')

package() {
    # extract *.deb
    cd ${srcdir}
    for f in $(ls -1 *.deb); do
        msg2 "Extracting ${f}"
        bsdtar -xvf ${f}
        bsdtar -xvf data.tar.gz -C ${pkgdir}/
    done

    # run with chromium
    find ${pkgdir} -iname "*.desktop" | xargs sed -i \
        's_Exec=/usr/bin/google-chrome_Exec=/usr/bin/chromium_'
}
