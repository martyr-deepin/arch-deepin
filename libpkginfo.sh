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

source ./libhelper.sh

mirror="http://packages.linuxdeepin.com"
# candidate mirrors
# "http://packages.linuxdeepin.com"
# "http://mirrors.ustc.edu.cn"
# "https://ftp.fau.de"
fileurl_prefix="deepin"
deepin_repo_sources=(
  "${mirror}/${fileurl_prefix}/dists/trusty/main/source/Sources.gz"
  "${mirror}/${fileurl_prefix}/dists/trusty/non-free/source/Sources.gz"
  "${mirror}/${fileurl_prefix}/dists/trusty/universe/source/Sources.gz"
)
local_sources=(
  "./debug/reposources/main"
  "./debug/reposources/non-free"
  "./debug/reposources/universe"
)

download_repo_sources() {
  rm -f debug/reposources/*
  local i=0
  for s in "${deepin_repo_sources[@]}"; do
    local l="${local_sources[${i}]}"
    msg "Download repo source: ${s}"
    curl --retry 3 --retry-delay 3 -o "${l}".gz "${s}"
    gunzip -f "${l}".gz
    ((i+=1))
  done
}

# output $pkg_version, $pkg_fileurl, $pkg_sha256sum, etc.
get_pkginfo() {
  unset pkg_name pkg_info pkg_directory pkg_version pkg_version_fixed
  unset pkg_files pkg_fileurls pkg_sha256sums pkg_file pkg_fileurl pkg_sha256sum
  unset obs_host obs_protocol obs_path
  pkg_name="${1}"
  pkg_info=$(grep_block "Package: ${pkg_name}\n" "${local_sources[@]}")
  if [ -z "${pkg_info}" ]; then
      error "get pkginfo failed: ${pkg_name}"
  fi
  pkg_directory=$(echo "${pkg_info}" | grep -m1 "^Directory:" | awk '{print $2}')
  pkg_version=$(echo "${pkg_info}" | grep -m1 "^Version:" | awk '{print $2}')
  pkg_version="${pkg_version#*:}"           # remove prefix version like "1:"

  # fix package version
  pkg_version_fixed="${pkg_version}"
  # remove special deepin version format, such as '-6deepin7'
  pkg_version_fixed="$(echo ${pkg_version_fixed} | sed 's/-[0-9]\?deepin[0-9]\?//')"
  pkg_version_fixed="${pkg_version_fixed%~trusty}" # remove suffix "~trusty"
  pkg_version_fixed="${pkg_version_fixed%~saucy}"  # remove suffix "~saucy"
  pkg_version_fixed="${pkg_version_fixed/\~/.}"    # replace "~" with "."
  pkg_version_fixed="${pkg_version_fixed/-/.}"     # replace "-" with "."
  pkg_version_fixed="${pkg_version_fixed/+/.}"     # replace "+" with "."

  # get all files' information
  pkg_files=($(echo "${pkg_info}" | awk 'BEGIN{output=0} /: /{output=0} /Files: /{output=1} NF==3{if(output){print}}' | awk '{print $3}'))
  pkg_fileurls=()
  for f in "${pkg_files[@]}"; do
    pkg_fileurls+=("${mirror}/${fileurl_prefix}/${pkg_directory}/${f}")
  done
  pkg_sha256sums=($(echo "${pkg_info}" | awk 'BEGIN{output=0} /: /{output=0} /Checksums-Sha256: /{output=1} NF==3{if(output){print}}' | awk '{print $1}'))

  # get the default source file's information
  pkg_file="${pkg_name}_${pkg_version}.tar.gz"
  pkg_fileurl="${mirror}/${fileurl_prefix}/${pkg_directory}/${pkg_file}"
  pkg_sha256sum=$(echo "${pkg_info}" | awk 'BEGIN{output=0} /: /{output=0} /Checksums-Sha256: /{output=1} NF==3{if(output){print}}' | grep "${pkg_file}" | awk '{print $1}')

  # split host, protocol and path from fileurl, used for _service in OBS
  obs_host="${mirror#*://}"
  obs_protocol="${mirror%://*}"
  obs_path="/${fileurl_prefix}/${pkg_directory}/${pkg_file}"
  obs_paths=()
  for f in "${pkg_files[@]}"; do
    obs_paths+=("/${fileurl_prefix}/${pkg_directory}/${f}")
  done
}
