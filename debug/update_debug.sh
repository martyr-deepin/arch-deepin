#!/bin/bash

source ../pkglist.sh

get_pkginfo_deepin() {
    rm pkgfilelist/deepin/* pkgstatus/deepin
    for p in "${pkglist_deepin[@]}"; do
        do_get_pkgfilelist_deepin "${p}"
        echo "" >> "pkgstatus/deepin"
        dpkg -s "${p}" >> "pkgstatus/deepin"
    done
}
do_get_pkgfilelist_deepin() {
    pkgname="${1}"
    dpkg -L "${pkgname}" | sort > "pkgfilelist/deepin/${pkgname}"
}

get_pkginfo_archlinux() {
    rm pkgfilelist/archlinux/* pkgstatus/archlinux
    for p in "${pkglist_archlinux[@]}"; do
        do_get_pkgfilelist_archlinux "${p}"
        echo "" >> "pkgstatus/archlinux"
        pacman -Qi "${p}" >> "pkgstatus/archlinux"
    done
}
do_get_pkgfilelist_archlinux() {
    pkgname="${1}"
    pacman -Ql "${pkgname}" | awk '{print $2}' | sort | sed 's=/$==' > "pkgfilelist/archlinux/${pkgname}"
}

get_pkginfo_"${1}"
