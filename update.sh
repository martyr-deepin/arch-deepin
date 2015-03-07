#!/bin/bash

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 3, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street, Fifth
# Floor, Boston, MA 02110-1301, USA.

# depends: curl, jq, makepkg, mkaurball, burp

source ./libhelper.sh
source ./libpkginfo.sh
source ./libjson.sh

###* Update package
update_pkg() {
  local pkgname="${1}"
  if do_update_pkg "${pkgname}"; then
      log_success "update-pkgbuild" "${pkgname} updated=$(get_package_updated_str ${pkgname}) version=$(get_package_lastversion ${pkgname})"
  else
    log_failed "update-pkgbuild" "${pkgname} updated=$(get_package_updated_str ${pkgname}) version=$(get_package_lastversion ${pkgname})"
  fi
  # copy files to release dir
  mkdir -p "${pkgbuilddir}/${pkgname}"
  find "${templatedir}/${pkgname}" -maxdepth 1 -type f -not -name '*.in' -exec cp -vf '{}' "${obsdir}/${pkgname}/" ';'
  find "${templatedir}/${pkgname}" -maxdepth 1 -type f -not '(' -name '*.in' -or -name '_service' ')' -exec cp -vf '{}' "${pkgbuilddir}/${pkgname}/" ';'
}
do_update_pkg() {
  local pkgname="${1}"
  msg "update package: ${pkgname}"
  case "${pkgname}" in
    *) gen_template "${pkgname}" || return 1;;
  esac
  update_package_state "${pkgname}" "${pkg_version}" "${pkg_version_fixed}"
}

gen_template() {
  local pkgname="${1}"
  get_pkginfo "$(get_package_originrepodir ${pkgname})" || return 1
  msg2 "pkg_version: ${pkg_version}"
  msg2 "pkg_version_fixed: ${pkg_version_fixed}"
  msg2 "pkg_directory: ${pkg_directory}"
  msg2 "pkg_file: ${pkg_file}"
  msg2 "pkg_fileurl: ${pkg_fileurl}"
  msg2 "pkg_sha256sum: ${pkg_sha256sum}"
  (
    cd "${templatedir}/${pkgname}"
    sed -e "s=@PKGVER@=${pkg_version}=g" \
        -e "s=@PKGVER_FIXED@=${pkg_version_fixed}=g" \
        -e "s=@SRCDIRNAME@=${pkg_srcdirname}=g" \
        -e "s=@SOURCE@=${pkg_fileurl}=g" \
        -e "s=@SOURCE_ORIG@=${pkg_fileurl_orig}=g" \
        -e "s=@SOURCE_DEBIAN@=${pkg_fileurl_debian}=g" \
        -e "s=@SHA256SUM@=${pkg_sha256sum}=g" \
        -e "s=@SHA256SUM_ORIG@=${pkg_sha256sum_orig}=g" \
        -e "s=@SHA256SUM_DEBIAN@=${pkg_sha256sum_debian}=g" \
        "${pkgbuild_in}" > PKGBUILD
    if [ -f "${service_in}" ]; then
        sed -e "s=@HOST@=${obs_host}=g" \
            -e "s=@PROTOCOL@=${obs_protocol}=g" \
            -e "s=@PATH@=${obs_path}=g" \
            -e "s=@PATH_ORIG@=${obs_path_orig}=g" \
            -e "s=@PATH_DEBIAN@=${obs_path_debian}=g" \
            "${service_in}" > _service
    fi
  )
}

gen_template_multi_sources() {
  local pkgname="${1}"; shift
  local fileindexes=("${@}")
  get_pkginfo "$(get_package_originrepodir ${pkgname})"
  msg2 "pkg_version: ${pkg_version}"
  msg2 "pkg_version_fixed: ${pkg_version_fixed}"
  msg2 "pkg_directory: ${pkg_directory}"
  for i in "${fileindexes[@]}"; do
    msg2 "pkg_files[${i}]: ${pkg_files[${i}]}"
    msg2 "pkg_fileurls[${i}]: ${pkg_fileurls[${i}]}"
    msg2 "pkg_sha256sums[${i}]: ${pkg_sha256sums[${i}]}"
  done
  (
    cd "${templatedir}/${pkgname}"
    sed -e "s=@PKGVER@=${pkg_version}=g" \
        -e "s=@PKGVER_FIXED@=${pkg_version_fixed}=g" "${pkgbuild_in}" > PKGBUILD
    if [ -f "${service_in}" ]; then
        sed -e "s=@HOST@=${obs_host}=g" \
            -e "s=@PROTOCOL@=${obs_protocol}=g" "${service_in}" > _service
    fi
    local tagi=1
    for i in "${fileindexes[@]}"; do
      sed -i -e "s=@SOURCE${tagi}@=${pkg_fileurls[${i}]}=g" \
          -e "s=@SHA256SUM${tagi}@=${pkg_sha256sums[${i}]}=g" PKGBUILD
      if [ -f "${service_in}" ]; then
          sed -i -e "s=@PATH${tagi}@=${obs_paths[${i}]}=g" _service
      fi
      ((tagi++))
    done
  )
}

###* Run makepkg
run_makepkg() {
  local pkgname="${1}"
  if do_run_makepkg "${pkgname}"; then
      log_success "makepkg" "${pkgname}"
  else
    log_failed "makepkg" "${pkgname}"
  fi
}
do_run_makepkg() {
  local pkgname="${1}"
  (cd "${pkgbuilddir}/${pkgname}"; rm -rf src pkg; makepkg -f) || return 1
}

###* Upload to AUR
aur_upload() {
  local pkgname="${1}"
  if do_aur_upload "${pkgname}"; then
      log_success "aur-upload" "${pkgname}"
  else
    log_failed "aur-upload" "${pkgname}"
  fi
}
do_aur_upload() {
  local pkgname="${1}"
  local pkgdir="${aurdir}/${pkgname}"

  # generate a new package source
  (cd "${pkgdir}"; mkaurball -f) || return 1

  local pkgsrc="$(ls --format=single-column --sort=time "${pkgdir}"/*.src.tar.gz | head -1)"
  local upcmd="$(printf "${aur_upload_cmd}" "${pkgsrc}")"
  printf "Uploading package source to AUR: %s...\n" "${pkgsrc}"
  printf "Upload command: %s\n" "${upcmd}"
  eval "${upcmd}" || return 1
}

###* Main
# basic configuration
set -e
LC_ALL=C
appfile="${0}"
appname="$(basename $0)"

# global variables
templatedir="template"
pkgbuilddir="pkgbuild"
aurdir="aur"
obsdir="obs/home:metakcahura:arch-deepin"
pkgbuild_in="PKGBUILD.in"
service_in="_service.in"
aur_upload_cmd="burp -v %s"

show_usage() {
  cat <<EOF
${appname} [options]
options:
    --package, -p
        only update target package
    --no-package, -n
        ignore target package
    --mark-updated, -U
        mark all package updated
    --no-download-reposources, -S
        do not download repo sources this time
    --makepkg, -m
        run makepkg for updated packages
    --aur-upload, -a
        upload updated packages to aur
    -h, --help
        show this message
EOF
  exit 1
}

# arguments
arg_show_usage=
arg_packages=()
arg_no_packages=()
arg_mark_updated=
arg_no_download_reposources=
arg_makepkg=
arg_aur_upload=

while [ $# -gt 0 ]; do
  case "${1}" in
    -h|--help) arg_show_usage=1; break;;
    -p|--package) arg_packages+=("${2}"); shift; shift;;
    -n|--no-package) arg_no_packages+=("${2}"); shift; shift;;
    -U|--mark-updated) arg_mark_updated=1; shift;;
    -S|--no-download-reposources) arg_no_download_reposources=1; shift;;
    -m|--makepkg) arg_makepkg=1; shift;;
    -a|--aur-upload) arg_aur_upload=1; shift;;
    *) shift;;
  esac
done

if [ "${arg_show_usage}" ]; then
    show_usage
fi

if [ ! "${arg_no_download_reposources}" ]; then
    download_repo_sources
fi

pkgs=()
if [ "${#arg_packages[@]}" -gt 0 ]; then
    pkgs=("${arg_packages[@]}")
else
  if [ "${arg_makepkg}" ]; then
      pkgs=($(find "${pkgbuilddir}"/* -maxdepth 0 -exec basename '{}' ';'))
  elif [ "${arg_aur_upload}" ]; then
      pkgs=($(find "${aurdir}"/* -maxdepth 0 -exec basename '{}' ';'))
  else
    pkgs=($(get_all_packages))
  fi
fi
for no_pkg in "${arg_no_packages[@]}"; do
  i=0
  for p in "${pkgs[@]}"; do
    if [ "${p}" = "${no_pkg}" ]; then
        unset pkgs[$i]
        break
    fi
    ((i+=1))
  done
done

if [ "${arg_makepkg}" ]; then
    log_begin "makepkg"
elif [ "${arg_aur_upload}" ]; then
    log_begin "aur-upload"
else
  log_begin "udpate-pkgbuild"
fi

for p in "${pkgs[@]}"; do
  if [ "${arg_mark_updated}" ]; then
      set_package_updated "${p}" "true"
  fi

  if [ "${arg_makepkg}" ]; then
      if get_package_updated "${p}"; then
          run_makepkg "${p}"
      fi
  elif [ "${arg_aur_upload}" ]; then
      if get_package_updated "${p}"; then
          aur_upload "${p}"
      fi
  else
    update_pkg "${p}"
  fi

  # ensure package updated again for that it may be changed when
  # updating package state
  if [ "${arg_mark_updated}" ]; then
      set_package_updated "${p}" "true"
  fi
done

# Local Variables:
# mode: sh
# mode: orgstruct
# orgstruct-heading-prefix-regexp: "^\s*###"
# End:
