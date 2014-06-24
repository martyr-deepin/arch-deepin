#!/bin/bash

source helper.sh

upload_cmd="burp -v %s"

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

    # fix package version
    pkg_version_fixed="${pkg_version%~*}"
    pkg_version_fixed="${pkg_version_fixed/-/_}"

    echo "pkg_version: ${pkg_version}"
    echo "pkg_version_fixed: ${pkg_version_fixed}"
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
        sed -e "s/@pkgver@/${pkg_version_fixed}/g" \
            -e "s=@fileurl@=${pkg_fileurl}=g" \
            -e "s/@sha256sum@/${pkg_sha256sum}/g" "${pkgbuild_in}" > PKGBUILD
    )
}

run_makepkg() {
    local pkgname=$1
    (cd "${pkgname}"; rm -rf src pkg; makepkg -f) || return 1
}

upload_pkg() {
    local pkgname=$1

    # generate a new package source
    (cd "${pkgname}"; mkaurball -f) || return 1

    local pkgsrc="$(ls --format=single-column --sort=time "${pkgname}"/*.src.tar.gz | head -1)"
    local upcmd="$(printf "${upload_cmd}" "${pkgsrc}")"
    printf "Uploading package source to AUR: %s...\n" "${pkgsrc}"
    printf "Upload command: %s\n" "${upcmd}"
    eval "${upcmd}" || return 1

}

do_update_pkg() {
    local pkgname=$1
    echo "==> update package: ${pkgname}"
    gen_pkgbuild "${pkgname}" || return 1
    run_makepkg "${pkgname}" || return 1
    upload_pkg "${pkgname}" || return 1
    echo
}

update_pkg() {
    do_update_pkg "$@"
    if (( $? )); then
        log_failed "$@"
    else
        log_success "$@"
    fi
}

download_debian_source

# update_pkg "deepin-game-center"
# update_pkg "deepin-media-player"
# update_pkg "deepin-music-player"
# update_pkg "deepin-screenshot"
update_pkg "deepin-terminal"
# update_pkg "deepin-ui"

# rm -vf "${tmp_source_file}"
