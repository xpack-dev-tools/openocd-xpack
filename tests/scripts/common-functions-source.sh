# -----------------------------------------------------------------------------
# Common functions used in various tests.
#
# Requires 
# - app_absolute_folder_path
# - test_absolute_folder_path
# - archive_platform (win32|linux|darwin)

# -----------------------------------------------------------------------------

function detect_architecture()
{
  uname -a

  uname_platform=$(uname -s | tr '[:upper:]' '[:lower:]')
  uname_machine=$(uname -m | tr '[:upper:]' '[:lower:]')

  node_platform="${uname_platform}"
  # Travis uses Msys2; git for Windows uses mingw-w64.
  if [[ "${uname_platform}" == msys_nt* ]] \
  || [[ "${uname_platform}" == mingw64_nt* ]] \
  || [[ "${uname_platform}" == mingw32_nt* ]]
  then
    node_platform="win32"
  fi

  node_architecture=""
  bits=""
  if [ "${uname_machine}" == "x86_64" ]
  then
    node_architecture="x64"
    bits="64"
  elif [ "${uname_machine}" == "i386" -o "${uname_machine}" == "i586" -o "${uname_machine}" == "i686" ]
  then
    node_architecture="x32"
    bits="32"
  elif [ "${uname_machine}" == "aarch64" ]
  then
    node_architecture="arm64"
    bits="64"
  elif [ "${uname_machine}" == "armv7l" -o "${uname_machine}" == "armv8l" ]
  then
    node_architecture="arm"
    bits="32"
  else
    echo "${uname_machine} not supported"
    exit 1
  fi
}

function prepare_env() 
{
  container_work_folder_absolute_path="/Host/Work"
  container_repo_folder_absolute_path="/Host/repo"

  if [ -f "/.dockerenv" ]
  then
    work_folder_absolute_path="${container_work_folder_absolute_path}"
    repo_folder_absolute_path="${container_repo_folder_absolute_path}"
  else
    work_folder_absolute_path="${HOME}/Work"
    # On the host, it must be called using the script folder path.
    repo_folder_absolute_path="$1"
  fi

  cache_absolute_folder_path="${work_folder_absolute_path}/cache"

  app_lc_name="openocd"

  # Extract only the first line
  version="$(cat ${repo_folder_absolute_path}/scripts/VERSION | sed -e '2,$d')"
  if [ -z "${version}" ]
  then
    echo "Check the version, it cannot be empty."
    exit 1
  fi

  # Always in the user home, even when inside a container.
  test_absolute_folder_path="${HOME}/test-${app_lc_name}"
}

# -----------------------------------------------------------------------------

# Requires base_url and lots of other variables.
function install_archive()
{
  local archive_extension
  local archive_architecture="${node_architecture}"
  if [ "${node_platform}" == "win32" ]
  then
    archive_extension="zip"
    if [ "${force_32_bit}" == "y" ]
    then
      archive_architecture="x32"
    fi
  else
    archive_extension="tar.gz"
  fi
  archive_name="xpack-${app_lc_name}-${version}-${node_platform}-${archive_architecture}.${archive_extension}"
  archive_folder_name="xpack-${app_lc_name}-${version}"

  mkdir -p "${cache_absolute_folder_path}"

  if [ ! -f "${cache_absolute_folder_path}/${archive_name}" ]
  then
    echo
    echo "Downloading ${archive_name}..."
    curl -L --fail -o "${cache_absolute_folder_path}/${archive_name}" \
      "${base_url}/${archive_name}"
  fi

  app_absolute_folder_path="${test_absolute_folder_path}/${archive_folder_name}"

  rm -rf "${app_absolute_folder_path}"

  mkdir -p "${test_absolute_folder_path}"
  cd "${test_absolute_folder_path}"

  echo
  echo "Extracting ${archive_name}..."
  if [[ "${archive_name}" == *.zip ]]
  then
    unzip -q "${cache_absolute_folder_path}/${archive_name}"
  else 
    tar xf "${cache_absolute_folder_path}/${archive_name}"
  fi

  ls -lL "${app_absolute_folder_path}"
}

# -----------------------------------------------------------------------------

# $1 = image name
# $2 = base URL
function docker_run_test() {
  local image_name="$1"
  shift

  local base_url="$1"
  shift

  (
    prefix32="${prefix32:-""}"

    docker run \
      --tty \
      --hostname "docker" \
      --workdir="/root" \
      --env DEBUG=${DEBUG} \
      --volume "${work_folder_absolute_path}:${container_work_folder_absolute_path}" \
      --volume "${repo_folder_absolute_path}:${container_repo_folder_absolute_path}" \
      "${image_name}" \
      ${prefix32} /bin/bash "${container_repo_folder_absolute_path}/tests/scripts/container-test.sh" \
        "${image_name}" \
        "${base_url}" \
        $@
  )
}

function docker_run_test_32() {
  (
    prefix32="linux32"

    docker_run_test $@
  )
}

# -----------------------------------------------------------------------------

function show_libs()
{
  # Does not include the .exe extension.
  local app_path=$1
  shift
  if [ "${node_platform}" == "win32" ]
  then
    app_path+='.exe'
  fi

  if [ "${node_platform}" == "linux" ]
  then
    echo
    echo "readelf -d ${app_path} | grep 'ibrary'"
    readelf -d "${app_path}" | grep 'ibrary'
    echo
    echo "ldd ${app_path}"
    ldd "${app_path}" 2>&1
  elif [ "${node_platform}" == "darwin" ]
  then
    echo
    echo "otool -L ${app_path}"
    otool -L "${app_path}"
  fi
}

function run_app()
{
  # Does not include the .exe extension.
  local app_path=$1
  shift

  echo
  echo "${app_path} $@"
  "${app_path}" $@ 2>&1
}

function good_bye()
{
  echo
  echo "All tests completed successfully."

  run_app uname -a
  if [ "${node_platform}" == "linux" ]
  then
    run_app lsb_release -a
    run_app ldd --version
  elif [ "${node_platform}" == "darwin" ]
  then
    run_app sw_vers
  fi
}

# -----------------------------------------------------------------------------

function run_tests()
{
  run_app "${app_absolute_folder_path}/bin/openocd" --version

  # TODO: add more, if possible.
}

# -----------------------------------------------------------------------------
