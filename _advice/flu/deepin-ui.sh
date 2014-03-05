# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>
# Contributor: 4679kun <admin[AT]4679.us>
# Contributor: dongfengweixiao <dongfengweixiao[AT]gmail.com>
# Contributor: flu

pkgname=deepin-ui
pkgver=git20140211094712
pkgrel=1
pkgdesc='UI toolkit for Linux Deepin'
arch=('i686' 'x86_64')
url="http://www.linuxdeepin.com/"
license=('GPL3')
depends=('deepin-utils' 'deepin-gsettings' 'deepin-pygtk-fix' 'python2-distribute' 'python2' 'glib2' 'python2-cairo' 'python2-imaging' 'libwebkit' 'python2-xlib' 'pywebkitgtk' 'libsoup')

source=("http://packages.linuxdeepin.com/deepin/pool/main/d/deepin-ui/deepin-ui_1+git20140303144244~29ba198b70.tar.gz")
sha256sums=('600d5775f3ea28f27ca7642746b8c25903a099714a4d1047154b384ee81110a1')

_filename="$(basename "${source}")"
_filename="${_filename%.tar.gz}"
_innerdir="${_filename/_/-}"

build(){
  cd "${srcdir}/${_innerdir}"
  python2 setup.py build
}

package() {
  cd "${srcdir}/${_innerdir}"
  mkdir -p "$pkgdir"/usr/share/locale "$pkgdir"/usr/lib/python2.7/site-packages/dtk/theme
  python2 setup.py install --root="$pkgdir/" --optimize=1
  mv "$pkgdir"/usr/dtk/locale "$pkgdir"/usr/share/
  mv "$pkgdir"/usr/dtk/theme "$pkgdir"/usr/lib/python2.7/site-packages/dtk/
  rm -rf "$pkgdir"/usr/dtk/

# fix python version
  find "${pkgdir}" -iname "*.py" -exec sed -i 's=\(^#! */usr/bin.*\)python=\1python2=' {} \;
}
