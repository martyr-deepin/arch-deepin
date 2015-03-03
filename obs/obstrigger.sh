#!/bin/bash

obs_dir="./home:metakcahura:arch-deepin"

obs_pkgs_dev=(
  go-dlib
  dbus-generator
  dbus-factory
)
obs_pkgs_extra=(
  deepin-music-player
  deepin-movie
  deepin-screenshot
  deepin-terminal
  deepin-game-center
)
obs_pkgs=(
  dde-api
  dde-daemon
  dde-workspace
  startdde
  deepin-qml-widgets
  qml-dde-dock-applet
  dde-control-center
  deepin-menu
  deepin-notifications
  deepin-gsettings
  deepin-default-gsettings
  dde-account-faces
  deepin-artwork
  deepin-artwork-themes
  deepin-cursor-theme
  deepin-compiz
  libdeepin-webkit
  deepin-icon-theme
)

obs_trigger_dev() {
  for p in ${obs_pkgs_dev[@]}; do
    do_obs_trigger_rerun "${obs_dir}/${p}"
  done
}
obs_trigger_extra() {
  for p in ${obs_pkgs_extra[@]}; do
    do_obs_trigger_rerun "${obs_dir}/${p}"
  done
}

obs_trigger() {
  for p in ${obs_pkgs_dev[@]} ${obs_pkgs_extra[@]} ${obs_pkgs[@]}; do
    do_obs_trigger_rerun "${obs_dir}/${p}"
  done
}
do_obs_trigger_rerun() {
  prj_dir="${1}"
  prj_name="$(basename ${1})"
  (
    echo "==> trigger re-run for ${prj_name}"
    cd "${obs_dir}/${p}"
    osc service rr
  )
}

obs_trigger
