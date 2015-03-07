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

cleanup_osc_dir() {
  find . -name '.osc' -type d -exec rm -rvf '{}' ';'
}

# ensure PKGBUILD.in, _service.in exists
ensure_pkgbuild_in_exists() {
  tpldir="${1}"
  (
    cd "${tpldir}"
    if [ ! -f PKGBUILD.in ]; then
        cp -vf PKGBUILD PKGBUILD.in
        sed -i -e 's/^pkgver=.*/pkgver=@PKGVER_FIXED@/' \
            -e 's/^source=([^)]*/source=("@SOURCE@"/' \
            -e "s/^sha256sums=([^)]*/sha256sums=('@SHA256SUM@'/" PKGBUILD.in
    fi
  )
}
ensure_service_in_exists() {
  tpldir="${1}"
  (
    cd "${tpldir}"
    if [ ! -f _service.in ]; then
        cp -vf _service _service.in
        sed -i -e 's/"host">[^<]*/"host">@OBS_HOST@/' \
        -e 's/"protocol">[^<]*/"protocol">@OBS_PROTOCOL@/' \
        -e 's/"path">[^<]*/"path">@OBS_PATH@/' \
             _service.in
    fi
  )
}

cleanup_osc_dir
for d in $(find * -maxdepth 0 -type d); do
  ensure_pkgbuild_in_exists "${d}"
  ensure_service_in_exists "${d}"
done
