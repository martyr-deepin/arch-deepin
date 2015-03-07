#!/bin/bash

cd ..
source ./libpkginfo.sh
cd -

# override variables
mirror="http://packages.linuxdeepin.com"
fileurl_prefix="deepin"
local_sources=(
  "./reposources/main"
  "./reposources/non-free"
  "./reposources/universe"
)

# check
check() {
  local value="${1}"
  local want="${2}"
  if [ x"${value}" != x"${want}" ]; then
      error "value=${value}, want=${want}"
  fi
}

# tests
test_get_pkginfo() {
  get_pkginfo "dde-daemon"
  check "${pkg_name}" "dde-daemon"
  check "${pkg_version}" "0.0.1+20150209101554~660a820a61"
  check "${pkg_version_fixed}" "0.0.1.20150209101554"
  check "${pkg_directory}" "pool/main/d/dde-daemon"
  check "${pkg_file}" "dde-daemon_0.0.1+20150209101554~660a820a61.tar.gz"
  check "${pkg_fileurl}" "http://packages.linuxdeepin.com/deepin/pool/main/d/dde-daemon/dde-daemon_0.0.1+20150209101554~660a820a61.tar.gz"
  check "${pkg_sha256sum}" "db271a63dc972c41a29bbbb6a30af897c4f7efe28e8ad3dbac37e061c508dd2c"
  check "${obs_host}" "packages.linuxdeepin.com"
  check "${obs_protocol}" "http"
  check "${obs_path}" "/deepin/pool/main/d/dde-daemon/dde-daemon_0.0.1+20150209101554~660a820a61.tar.gz"

}

test_get_pkginfo_multiple_sources() {
  get_pkginfo "vte"
  check "${pkg_name}" "vte"
  check "${pkg_version}" "0.28.2-6deepin7~saucy"
  check "${pkg_version_fixed}" "0.28.2"
  check "${pkg_directory}" "pool/main/v/vte"
  check "${#pkg_files[@]}" 3
  check "${pkg_files[0]}" "vte_0.28.2-6deepin7~saucy.dsc"
  check "${pkg_files[1]}" "vte_0.28.2.orig.tar.xz"
  check "${pkg_files[2]}" "vte_0.28.2-6deepin7~saucy.debian.tar.gz"
  check "${#pkg_fileurls[@]}" 3
  check "${pkg_fileurls[0]}" "http://packages.linuxdeepin.com/deepin/pool/main/v/vte/vte_0.28.2-6deepin7~saucy.dsc"
  check "${pkg_fileurls[1]}" "http://packages.linuxdeepin.com/deepin/pool/main/v/vte/vte_0.28.2.orig.tar.xz"
  check "${pkg_fileurls[2]}" "http://packages.linuxdeepin.com/deepin/pool/main/v/vte/vte_0.28.2-6deepin7~saucy.debian.tar.gz"
  check "${#pkg_sha256sums[@]}" 3
  check "${pkg_sha256sums[0]}" "44f390fea99f6ea13ddda98ed16bf20f9d4b2935e6e81d305b608c4485361a58"
  check "${pkg_sha256sums[1]}" "ee52b91ecab31d0a64399896ce0c3515e579ea8ac212a00eb9b0895c58f001fe"
  check "${pkg_sha256sums[2]}" "b63a344541f0feebddac0232a8d7196d22d4819ec32cbd6cb39e33b2ba50e940"
  check "${#obs_paths[@]}" 3
  check "${obs_paths[0]}" "/deepin/pool/main/v/vte/vte_0.28.2-6deepin7~saucy.dsc"
  check "${obs_paths[1]}" "/deepin/pool/main/v/vte/vte_0.28.2.orig.tar.xz"
  check "${obs_paths[2]}" "/deepin/pool/main/v/vte/vte_0.28.2-6deepin7~saucy.debian.tar.gz"
  check ""
  check "${pkg_file_orig}" "vte_0.28.2.orig.tar.xz"
  check "${pkg_file_debian}" "vte_0.28.2-6deepin7~saucy.debian.tar.gz"
  check "${pkg_fileurl_orig}" "http://packages.linuxdeepin.com/deepin/pool/main/v/vte/vte_0.28.2.orig.tar.xz"
  check "${pkg_fileurl_debian}" "http://packages.linuxdeepin.com/deepin/pool/main/v/vte/vte_0.28.2-6deepin7~saucy.debian.tar.gz"
  check "${pkg_sha256sum_orig}" "ee52b91ecab31d0a64399896ce0c3515e579ea8ac212a00eb9b0895c58f001fe"
  check "${pkg_sha256sum_debian}" "b63a344541f0feebddac0232a8d7196d22d4819ec32cbd6cb39e33b2ba50e940"
  check "${obs_path_orig}" "/deepin/pool/main/v/vte/vte_0.28.2.orig.tar.xz"
  check "${obs_path_debian}" "/deepin/pool/main/v/vte/vte_0.28.2-6deepin7~saucy.debian.tar.gz"
}

test_get_pkginfo_fixed_version() {
  get_pkginfo "compiz"
  check "${pkg_version}" "0.9.99-5+git20140707164843~2e85d002e7"
  check "${pkg_version_fixed}" "0.9.99.5.git20140707164843"
  check "${pkg_version_src}" "0.9.99"

  get_pkginfo "dde-account-faces"
  check "${pkg_version}" "1.0.7-1~trusty"
  check "${pkg_version_fixed}" "1.0.7"
  check "${pkg_version_src}" "1.0.7"

  get_pkginfo "deepin-artwork"
  check "${pkg_version}" "2014-4"
  check "${pkg_version_fixed}" "2014"
  check "${pkg_version_src}" "2014"

  get_pkginfo "deepin-artwork-themes"
  check "${pkg_version}" "14.04.3+20141204110221~5bf78d7f42"
  check "${pkg_version_fixed}" "14.04.3.20141204110221"
  check "${pkg_version_src}" "14.04.3+20141204110221~5bf78d7f42"

  get_pkginfo "deepin-bug-reporter"
  check "${pkg_version}" "1+20141029130135~d2afb454d7"
  check "${pkg_version_fixed}" "1.20141029130135"
  check "${pkg_version_src}" "1+20141029130135~d2afb454d7"

  get_pkginfo "deepin-cursor-theme"
  check "${pkg_version}" "2014~4-2"
  check "${pkg_version_fixed}" "2014.4"
  check "${pkg_version_src}" "2014~4"

  get_pkginfo "deepin-default-settings"
  check "${pkg_version}" "2014~12-35~trusty"
  check "${pkg_version_fixed}" "2014.12"
  check "${pkg_version_src}" "2014~12"

  get_pkginfo "deepin-icon-theme-v2013"
  check "${pkg_version}" "1.0-1"
  check "${pkg_version_fixed}" "1.0"
  check "${pkg_version_src}" "1.0"

  get_pkginfo "vte"
  check "${pkg_version}" "0.28.2-6deepin7~saucy"
  check "${pkg_version_fixed}" "0.28.2"
  check "${pkg_version_src}" "0.28.2"

  get_pkginfo "qtav"
  check "${pkg_version}" "1.4.2-deepin3"
  check "${pkg_version_fixed}" "1.4.2"
  check "${pkg_version_src}" "1.4.2"

  get_pkginfo "golang-go-sqlite3"
  check "${pkg_version}" "0.0~git20140913-1"
  check "${pkg_version_fixed}" "0.0.git20140913"
  check "${pkg_version_src}" "0.0~git20140913"

  get_pkginfo "golang-gocheck"
  check "${pkg_version}" "0.0~bzr20131118+85-6"
  check "${pkg_version_fixed}" "0.0.bzr20131118.85"
  check "${pkg_version_src}" "0.0~bzr20131118+85"
}

# simple test runner
appfile="${0}"
get_all_tests() {
  grep -o '^test_[^(]*' "${appfile}"
}
run_all_tests() {
  for t in $(get_all_tests); do
    msg "run $t"
    $t
  done
}
run_all_tests
