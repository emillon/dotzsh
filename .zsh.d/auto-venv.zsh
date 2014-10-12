# Suggest to load a virtualenv named like the current directory

function chpwd_autovenv() {
  local venvname="$(basename $PWD)"
  local venvdir="$HOME/.virtualenvs/$venvname"
  local venvact="$venvdir/bin/activate"

  # Abort if :
  #   - no venv seems to exist
  if [ ! -e "$venvact" ] ; then
    return
  fi
  #   - a venv is already active
  if [ -n "$VIRTUAL_ENV" ] ; then
    return
  fi
  #   - current directory is /
  if [ "$venvname" = / ] ; then
    return
  fi

  echo -n '\e[33m'
  echo -n "Found a virtualenv in $venvdir. Activate? [yn] "
  echo -n '\e[0m'
  read -q
  local do_act=$?
  echo
  if [ $do_act -eq 0 ] ; then
    source "$venvact"
  fi
}

chpwd_functions=(${chpwd_functions[@]} "chpwd_autovenv")

function mkvenv() {
  local venvname="$(basename $PWD)"
  local venvdir="$HOME/.virtualenvs/$venvname"
  local venvact="$venvdir/bin/activate"

  if [ -e "$venvdir" ] ; then
    echo '\e[31mA virtualenv with this name already exists\e[m'
    return 1
  fi

  virtualenv "$venvdir"
  source "$venvact"
}

function delvenv() {
  local venvname="$(basename $PWD)"
  local venvdir="$HOME/.virtualenvs/$venvname"
  echo "\e[33mDeactivating and removing venv: $venvname\e[m"
  deactivate
  rm -rf "$venvdir"
}
