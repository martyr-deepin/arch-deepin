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

get_all_packages() {
  jq -r '.[].Name' packages.json
}

get_package_originrepodir() {
  jq -r "map(select(.Name==\"${1}\")) | .[].OriginRepoDir" packages.json
}

get_package_updated_str() {
  if get_package_updated "${1}"; then
      echo "true"
  else
      echo "false"
  fi
}
get_package_updated() {
  if [ "$(jq -r "map(select(.Name==\"${1}\")) | .[].Updated" packages.json)" = "true" ]; then
      return 0
  else
    return 1
  fi
}
set_package_updated() {
  jq "map({Name, OriginRepoDir, Updated: (if .Name == \"${1}\" then ${2} else .Updated end), VersionPrefix, LastVersion, LastVersionFixed})" packages.json > __packages.json
  mv -f __packages.json packages.json
}

get_package_versionprefix() {
  jq -r "map(select(.Name==\"${1}\")) | .[].VersionPrefix" packages.json
}

get_package_lastversion() {
  jq -r "map(select(.Name==\"${1}\")) | .[].LastVersion" packages.json
}
set_package_lastversion() {
  jq "map({Name, OriginRepoDir, Updated, VersionPrefix, LastVersion: (if .Name == \"${1}\" then \"${2}\" else .LastVersion end), LastVersionFixed})" packages.json > __packages.json
  mv -f __packages.json packages.json
}

get_package_lastversionfixed() {
  jq -r "map(select(.Name==\"${1}\")) | .[].LastVersionFixed" packages.json
}
set_package_lastversionfixed() {
  jq "map({Name, OriginRepoDir, Updated, VersionPrefix, LastVersion, LastVersionFixed: (if .Name == \"${1}\" then \"${2}\" else .LastVersionFixed end)})" packages.json > __packages.json
  mv -f __packages.json packages.json
}

update_package_state() {
  local pkgname="${1}"
  local pkgvel="${2}"
  local pkgvelfixed="${3}"
  if [ "${pkgvel}" != "$(get_package_lastversion ${pkgname})" ]; then
      set_package_updated "${pkgname}" true
  else
      set_package_updated "${pkgname}" false
  fi
  set_package_lastversion "${pkgname}" "${pkgvel}"
  set_package_lastversionfixed "${pkgname}" "${pkgvelfixed}"
}
