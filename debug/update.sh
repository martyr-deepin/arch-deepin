#!/bin/bash

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 3, or
# (at your option) any later version.

source ./libhelper.sh
source ./libdebianrepo.sh
source ./libpkglist.sh

action_collect_deepin() {
  # download_repo_sources
  rm -f filelist/deepin/* desc/deepin
  for p in "${pkglist_deepin[@]}"; do
    do_action_collect_deepin "${p}"
    echo "" >> "desc/deepin"
    dpkg -s "${p}" >> "desc/deepin"
  done
}
do_action_collect_deepin() {
  pkgname="${1}"
  dpkg -L "${pkgname}" | sort | grep -v '^/usr/share/doc\|^/usr/share$\|^/\.$' | \
      sed 's#/usr/lib/x86_64-linux-gnu/qt5/qml#/usr/lib/qt/qml#' | \
      sed 's#/usr/lib/python2.7/dist-packages#/usr/lib/python2.7/site-packages#' \
      > "filelist/deepin/${pkgname}"
}

action_collect_archlinux() {
  rm -f filelist/archlinux/* desc/archlinux
  for p in "${pkglist_archlinux[@]}"; do
    do_action_collect_archlinux "${p}"
    echo "" >> "desc/archlinux"
    pacman -Qi "${p}" >> "desc/archlinux"
  done
}
do_action_collect_archlinux() {
  pkgname="${1}"
  pacman -Ql "${pkgname}" | sed 's/[^ ]* //' | sort | sed 's=/$==' | \
      grep -v '^/usr/share$' > "filelist/archlinux/${pkgname}"
}

action_diff_filelist() {
  cd filelist
  local filelist_diff=../filelist.diff
  rm -f "${filelist_diff}"
  diff deepin/dde-account-faces archlinux/deepin-account-faces >> "${filelist_diff}"
  diff deepin/dde-api archlinux/deepin-api >> "${filelist_diff}"
  diff deepin/deepin-artwork-themes archlinux/deepin-artwork-themes >> "${filelist_diff}"
  diff deepin/dde-control-center archlinux/deepin-control-center >> "${filelist_diff}"
  diff deepin/dde-daemon archlinux/deepin-daemon >> "${filelist_diff}"
  diff deepin/dde-qml-dbus-factory archlinux/deepin-dbus-factory >> "${filelist_diff}"
  diff deepin/dbus-generator archlinux/deepin-dbus-generator >> "${filelist_diff}"
  diff deepin/dde-desktop archlinux/deepin-desktop >> "${filelist_diff}"
  diff deepin/deepin-desktop-base archlinux/deepin-desktop-base >> "${filelist_diff}"
  diff deepin/deepin-desktop-schemas archlinux/deepin-desktop-schemas >> "${filelist_diff}"
  diff deepin/dde-dock archlinux/deepin-dock >> "${filelist_diff}"
  diff deepin/deepin-file-manager-backend archlinux/deepin-file-manager >> "${filelist_diff}"
  diff deepin/deepin-gettext-tools archlinux/deepin-gettext-tools >> "${filelist_diff}"
  diff deepin/golang-gir-generator archlinux/deepin-gir-generator >> "${filelist_diff}"
  diff deepin/grub-themes-deepin archlinux/deepin-grub2-themes >> "${filelist_diff}"
  diff deepin/deepin-gtk-theme archlinux/deepin-gtk-theme >> "${filelist_diff}"
  diff deepin/deepin-icon-theme archlinux/deepin-icon-theme >> "${filelist_diff}"
  diff deepin/dde-launcher archlinux/deepin-launcher >> "${filelist_diff}"
  diff deepin/deepin-menu archlinux/deepin-menu >> "${filelist_diff}"
  # diff deepin/deepin-metacity archlinux/deepin-metacity >> "${filelist_diff}"
  diff deepin/deepin-movie archlinux/deepin-movie >> "${filelist_diff}"
  diff deepin/deepin-music archlinux/deepin-music >> "${filelist_diff}"
  # diff deepin/deepin-mutter archlinux/deepin-mutter >> "${filelist_diff}"
  diff deepin/deepin-nautilus-properties archlinux/deepin-nautilus-properties >> "${filelist_diff}"
  diff deepin/deepin-notifications archlinux/deepin-notifications >> "${filelist_diff}"
  # diff deepin/deepin-qml-widgets archlinux/deepin-qml-widgets >> "${filelist_diff}"
  diff deepin/deepin-screenshot archlinux/deepin-screenshot >> "${filelist_diff}"
  diff deepin/dde-session-ui archlinux/deepin-session-ui >> "${filelist_diff}"
  diff deepin/deepin-social-sharing archlinux/deepin-social-sharing >> "${filelist_diff}"
  diff deepin/deepin-sound-theme archlinux/deepin-sound-theme >> "${filelist_diff}"
  diff deepin/deepin-terminal archlinux/deepin-terminal >> "${filelist_diff}"
  # diff deepin/deepin-wm archlinux/deepin-wm >> "${filelist_diff}"
  diff deepin/deepin-wm-switcher archlinux/deepin-wm-switcher >> "${filelist_diff}"
  diff deepin/libdui1 archlinux/libdui >> "${filelist_diff}"
  # diff deepin/python-deepin-gsettings archlinux/python2-deepin-gsettings >> "${filelist_diff}"
  # diff deepin/python-deepin-storm archlinux/python2-deepin-storm >> "${filelist_diff}"
  # diff deepin/deepin-ui archlinux/python2-deepin-ui >> "${filelist_diff}"
  # diff deepin/python-deepin-utils archlinux/python2-deepin-utils >> "${filelist_diff}"
  diff deepin/startdde archlinux/startdde  >> "${filelist_diff}"
  echo Done
}

if [ $# -eq 0 ]; then
    echo "Available arguments:"
    get_action_funcs
    exit 0
fi

action_"${1}"
