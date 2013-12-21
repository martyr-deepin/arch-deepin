# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>

pkgname=deepin-system-settings
pkgver={% pkgver %}
pkgrel=1
pkgdesc='Utility classes for using DCM modules in Linux Deepin environment'
arch=('i686' 'x86_64')
url="http://www.linuxdeepin.com/"
license=('GPL2')
depends=('deepin-ui' 'deepin-gsettings' 'polkit' 'python2-pexpect' 'gstreamer0.10' 'python2-psutil' 'bluez' 'obex-data-server' 'xautomation' 'python2-dbus' 'python2-gtop')
         # 'deepin-xrandr' 'python-deepin-storm'

_pkgsite="http://packages.linuxdeepin.com"
# _pkgsite="http://mirrors.ustc.edu.cn" # candidate server
_parent_url="${_pkgsite}/deepin/pool/main/d/${pkgname}"
source=("${_parent_url}/{% filename %}"
        "${_parent_url}/{% modname_1 %}"
        "${_parent_url}/{% modname_2 %}"
        "${_parent_url}/{% modname_3 %}"
        "${_parent_url}/{% modname_4 %}"
        "${_parent_url}/{% modname_5 %}"
        "${_parent_url}/{% modname_6 %}"
        "${_parent_url}/{% modname_7 %}"
        "${_parent_url}/{% modname_8 %}"
        "${_parent_url}/{% modname_9 %}"
        "${_parent_url}/{% modname_10 %}"
        "${_parent_url}/{% modname_11 %}"
        "${_parent_url}/{% modname_12 %}"
        "${_parent_url}/{% modname_13 %}"
        "${_parent_url}/{% modname_14 %}"
        "${_parent_url}/{% modname_15 %}"
        "${_parent_url}/{% modname_16 %}"
        "${_parent_url}/{% modname_17 %}"
        "${_parent_url}/{% modname_18 %}"
        "${_parent_url}/{% modname_19 %}"
        "${_parent_url}/{% modname_20 %}"
        )
md5sums=('{% md5 %}'
         '{% md5mod_1 %}'
         '{% md5mod_2 %}'
         '{% md5mod_3 %}'
         '{% md5mod_4 %}'
         '{% md5mod_5 %}'
         '{% md5mod_6 %}'
         '{% md5mod_7 %}'
         '{% md5mod_8 %}'
         '{% md5mod_9 %}'
         '{% md5mod_10 %}'
         '{% md5mod_11 %}'
         '{% md5mod_12 %}'
         '{% md5mod_13 %}'
         '{% md5mod_14 %}'
         '{% md5mod_15 %}'
         '{% md5mod_16 %}'
         '{% md5mod_17 %}'
         '{% md5mod_18 %}'
         '{% md5mod_19 %}'
         '{% md5mod_20 %}'
        )

package() {
    # extract *.deb
    cd ${srcdir}
    for f in $(ls -1 *.deb); do
        msg2 "Extracting ${f}"
        bsdtar -xvf ${f}
        bsdtar -xvf data.tar.gz -C ${pkgdir}/
    done

    # fix python version
    find ${pkgdir} -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python=\1python2='

    # fix python problem more
    cd ${pkgdir}/usr/share/deepin-system-settings/

    # /usr/share/deepin-system-settings/dss/main.py
    sed -i 's/subprocess.Popen("python %s/subprocess.Popen("python2 %s/' \
        dss/main.py

    sed -i "s/startswith('python')/startswith('python2')/" \
        modules/sound/src/tray_sound_gui_small.py

    sed -i "s/'command': \"python /'command': \"python2 /" \
        modules/keyboard/src/keybind_all.py
    sed -i "s/'command': 'python /'command': 'python2 /" \
        modules/keyboard/src/keybind_all.py

    sed -i 's/subprocess.Popen("python %s/subprocess.Popen("python2 %s/' \
        modules/bluetooth/src/tray_bluetooth_plugin.py
}
