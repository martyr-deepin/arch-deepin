#!/bin/bash

# reset_obs_file home:metakcahura:arch-deepin qtav PKGBUILD
reset_obs_file() {
  local obs_project="${1}"
  local obs_package="${2}"
  local obs_file="${3}"
  echo "==> ${obs_project} ${obs_package} ${obs_file}"
  
  local obs_path_dir="${obs_project}/${obs_package}"
  local obs_path_file="${obs_project}/${obs_package}/${obs_file}"
  
  if [ ! -f "${obs_path_file}" ]; then
      echo "  ->  ${obs_path_file} not a file"
      return 1
  fi
  
  (
    cd "${obs_path_dir}"
    osc checkout "${obs_project}" "${obs_package}" "${obs_file}"
  )
}

obs_project="home:metakcahura:arch-deepin"
for f in $(osc status "${obs_project}" | grep 'C ' | awk '{print $2}'); do
  args=($(echo "${f}" | sed 's=/= =g'))
  reset_obs_file "${args[@]}"
done

