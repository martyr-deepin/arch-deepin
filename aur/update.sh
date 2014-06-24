#!/bin/bash

_pkgsite="http://packages.linuxdeepin.com"
# _pkgsite="http://mirrors.ustc.edu.cn" # candidate server
pkgsite="${_pkgsite}/deepin"
deepin_debian_source="${pkgsite}/dists/trusty/main/source/Sources.gz"
pkgbuild_in="PKGBUILD.in"
tmp_source_file="/tmp/sources"

download_debian_source() {
    curl --retry 3 --retry-delay 3 -o "${tmp_source_file}".gz "${deepin_debian_source}"
    gunzip -f "${tmp_source_file}".gz
}

grep_block() {
    local keyword="$1"; shift
    local files=$@
    awk -v keyword="${keyword}" 'BEGIN{RS="\n\n"} $0 ~ keyword{print ""; print; n++}' $files
}

# $pkg_version, $pkg_directory, $pkg_sha256sum
get_pkg_info() {
    local pkgname=$1
    pkg_info=$(grep_block "Package: ${pkgname}" "${tmp_source_file}")
    pkg_version=$(echo "$pkg_info" | grep -m1 "^Version:" | awk '{print $2}')
    pkg_directory=$(echo "$pkg_info" | grep -m1 "^Directory:" | awk '{print $2}')
    pkg_file="${pkgname}_${pkg_version}.tar.gz"
    pkg_fileurl="${pkgsite}/${pkg_directory}/${pkg_file}"
    pkg_sha256sum=$(echo "$pkg_info" | awk 'BEGIN{RS="Checksums-Sha256:"}{if(NR==2){print}}' | grep "${pkg_file}" | awk '{print $1}')
    echo "pkg_version: ${pkg_version}"
    echo "pkg_directory: ${pkg_directory}"
    echo "pkg_file: ${pkg_file}"
    echo "pkg_fileurl: ${pkg_fileurl}"
    echo "pkg_sha256sum: ${pkg_sha256sum}"
}

gen_pkgbuild() {
    local pkgname=$1
    get_pkg_info "${pkgname}"
    (
        cd "${pkgname}"
        sed -e "s/@pkgver@/${pkg_version}/g" \
            -e "s=@fileurl@=${pkg_fileurl}=g" \
            -e "s/@sha256sum@/${pkg_sha256sum}/g" "${pkgbuild_in}" > PKGBUILD
    )
}

make_pkg() {
    local pkgname=$1
    (
        cd "${pkgname}"
    )
}

push_to_aur() {
    local pkgname=$1
    (
        cd "${pkgname}"
    )
}

update_pkg() {
    local pkgname=$1
    echo "==> update package: ${pkgname}"
    gen_pkgbuild "${pkgname}"
    make_pkg "${pkgname}"
    push_to_aur "${pkgname}"
    echo
}

download_debian_source
update_pkg "deepin-game-center"
# update_pkg "deepin-media-player"
# update_pkg "deepin-music-player"
# update_pkg "deepin-screenshot"
# update_pkg "deepin-terminal"
# update_pkg "deepin-ui"

# rm -vf "${tmp_source_file}"
