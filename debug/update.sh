#!/bin/bash

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 3, or
# (at your option) any later version.

source ./libhelper.sh
source ./libdebianrepo.sh
source ./libpkglist.sh

action_collect_deepin() {
  download_repo_sources
  rm -f pkgfilelist/deepin/* pkgdesc/deepin
  for p in "${pkglist_deepin[@]}"; do
    do_action_collect_deepin "${p}"
    echo "" >> "pkgdesc/deepin"
    dpkg -s "${p}" >> "pkgdesc/deepin"
  done
}
do_action_collect_deepin() {
  pkgname="${1}"
  dpkg -L "${pkgname}" | sort > "pkgfilelist/deepin/${pkgname}"
}

action_collect_archlinux() {
  rm -f pkgfilelist/archlinux/* pkgdesc/archlinux
  for p in "${pkglist_archlinux[@]}"; do
    do_action_collect_archlinux "${p}"
    echo "" >> "pkgdesc/archlinux"
    pacman -Qi "${p}" >> "pkgdesc/archlinux"
  done
}
do_action_collect_archlinux() {
  pkgname="${1}"
  pacman -Ql "${pkgname}" | awk '{print $2}' | sort | sed 's=/$==' > "pkgfilelist/archlinux/${pkgname}"
}

action_diff_filelist() {
  cd pkgfilelist
  rm -f filelist.diff
  diff deepin/deepin-account-faces archlinux/dde-account-faces >> filelist.diff
  diff deepin/deepin-api archlinux/dde-api >> filelist.diff
  diff deepin/deepin-artwork-themes archlinux/deepin-artwork-themes >> filelist.diff
  diff deepin/deepin-control-center archlinux/dde-control-center >> filelist.diff
  diff deepin/deepin-daemon archlinux/dde-daemon >> filelist.diff
  diff deepin/deepin-dbus-factory archlinux/dde-qml-dbus-factory >> filelist.diff
  diff deepin/deepin-dbus-generator archlinux/dbus-generator >> filelist.diff
  diff deepin/deepin-desktop archlinux/dde-desktop >> filelist.diff
  diff deepin/deepin-desktop-base archlinux/deepin-desktop-base >> filelist.diff
  diff deepin/deepin-desktop-schemas archlinux/deepin-desktop-schemas >> filelist.diff
  diff deepin/deepin-dock archlinux/dde-dock >> filelist.diff
  diff deepin/deepin-file-manager archlinux/deepin-file-manager-backend >> filelist.diff
  diff deepin/deepin-gettext-tools archlinux/deepin-gettext-tools >> filelist.diff
  diff deepin/deepin-gir-generator archlinux/golang-gir-generator >> filelist.diff
  diff deepin/deepin-grub2-themes archlinux/grub-themes-deepin >> filelist.diff
  diff deepin/deepin-gtk-theme archlinux/deepin-gtk-theme >> filelist.diff
  diff deepin/deepin-icon-theme archlinux/deepin-icon-theme >> filelist.diff
  diff deepin/deepin-launcher archlinux/dde-launcher >> filelist.diff
  diff deepin/deepin-menu archlinux/deepin-menu >> filelist.diff
  # diff deepin/deepin-metacity archlinux/deepin-metacity >> filelist.diff
  diff deepin/deepin-movie archlinux/deepin-movie >> filelist.diff
  diff deepin/deepin-music archlinux/deepin-music >> filelist.diff
  # diff deepin/deepin-mutter archlinux/deepin-mutter >> filelist.diff
  diff deepin/deepin-nautilus-properties archlinux/deepin-nautilus-properties >> filelist.diff
  diff deepin/deepin-notifications archlinux/deepin-notifications >> filelist.diff
  # diff deepin/deepin-qml-widgets archlinux/deepin-qml-widgets >> filelist.diff
  diff deepin/deepin-screenshot archlinux/deepin-screenshot >> filelist.diff
  diff deepin/deepin-session-ui archlinux/dde-session-ui >> filelist.diff
  diff deepin/deepin-social-sharing archlinux/deepin-social-sharing >> filelist.diff
  diff deepin/deepin-sound-theme archlinux/deepin-sound-theme >> filelist.diff
  diff deepin/deepin-terminal archlinux/deepin-terminal >> filelist.diff
  # diff deepin/deepin-wm archlinux/deepin-wm >> filelist.diff
  diff deepin/deepin-wm-switcher archlinux/deepin-wm-switcher >> filelist.diff
  diff deepin/libdui archlinux/libdui1 >> filelist.diff
  diff deepin/python2-deepin-gsettings archlinux/python-deepin-gsettings >> filelist.diff
  # diff deepin/python2-deepin-storm archlinux/python-deepin-storm >> filelist.diff
  # diff deepin/python2-deepin-ui archlinux/deepin-ui >> filelist.diff
  # diff deepin/python2-deepin-utils archlinux/python-deepin-utils >> filelist.diff
  diff deepin/startdde archlinux/startdde >> filelist.diff
  echo Done
}

if [ $# -eq 0 ]; then
    echo "Available arguments:"
    get_action_funcs
    exit 0
fi

action_"${1}"
