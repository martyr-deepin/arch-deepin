# This package is maintained by 'pkgbuildup', and will update weekly,
# if something wrong just notice me please.
# Maintainer: Xu Fasheng <fasheng.xu@gmail.com>

pkgname=deepin-webapps
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Webapps from Deepin Linux'
arch=('i686' 'x86_64')
depends=('chromium' 'xdg-utils')
license=('GPL3')
provides=("${pkgname}")
conflicts=("${pkgname}-git")
url="http://www.linuxdeepin.com/"
_pkgsite="http://packages.linuxdeepin.com"
# _pkgsite="http://mirrors.ustc.edu.cn" # candidate server
_parent_url="${_pkgsite}/deepin/pool/main/d/deepin-system-settings"
source=("${_parent_url}/{% filename_1 %}"
        "${_parent_url}/{% filename_2 %}"
        "${_parent_url}/{% filename_3 %}"
        "${_parent_url}/{% filename_4 %}"
        "${_parent_url}/{% filename_5 %}"
        "${_parent_url}/{% filename_6 %}"
        "${_parent_url}/{% filename_7 %}"
        "${_parent_url}/{% filename_8 %}"
        "${_parent_url}/{% filename_9 %}"
        "${_parent_url}/{% filename_10 %}"
        "${_parent_url}/{% filename_11 %}"
        "${_parent_url}/{% filename_12 %}"
        "${_parent_url}/{% filename_13 %}"
        "${_parent_url}/{% filename_14 %}"
        "${_parent_url}/{% filename_15 %}"
        "${_parent_url}/{% filename_16 %}"
        "${_parent_url}/{% filename_17 %}"
        "${_parent_url}/{% filename_18 %}"
        "${_parent_url}/{% filename_19 %}"
        "${_parent_url}/{% filename_20 %}"
        "${_parent_url}/{% filename_21 %}"
        "${_parent_url}/{% filename_22 %}"
        "${_parent_url}/{% filename_23 %}"
        )
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
         '{% md5_23 %}'
        )

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

