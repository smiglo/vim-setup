#!/bin/bash
# vim: fdl=0

if [[ $1 == '@@' ]]; then # {{{
  check() { # {{{
    local args="$1" v="$2"
    excl=" $v \|" incl=
    shift 2
    while [[ ! -z $1 ]]; do
      [[ $1 == '--' ]] && break
      excl+=" $1 \|"
      shift
    done
    echo " $args " | command grep -q "${excl:0:-2}" && return 0
    while [[ ! -z $1 ]]; do
      incl+=" $1 \|"
      shift
    done
    [[ -z $incl ]] && incl="^\|"
    echo " $args " | command grep -q "${incl:0:-2}" && echo "$v"
    return 0
  } # }}}
  case $3 in
  -p) ls -d */;;
  *)  ret=""
      args="${@:4}"
      ret+=" $(check "$args" -p)"
      ret+=" $(check "$args" -q)"
      ret+=" $(check "$args" -n -d --check)"
      ret+=" $(check "$args" --check -d -D)"
      ret+=" $(check "$args" -d --check --force -D)"
      ret+=" $(check "$args" -D --check --force -d)"
      ret+=" $(check "$args" --force -d -D --check)"
      ret+=" $(check "$args" --diff -- -d -D)"
      echo "$ret"
      ;;
  esac
  exit 0
fi # }}}
VIM_EXE="../vim" dry=false wtd='INSTALL' show_diff=false quiet=false plugin= list= force=false
while [[ ! -z $1 ]]; do # {{{
  case $1 in
  -n | -d) dry=true;;&
  -n);;
  -d) ! $quiet && echo -e "\nDry run, use -D to uninstall\n";;&
  -D | -d) wtd='UNINSTALL';;
  --diff) show_diff=true;;
  --check) wtd='CHECK';;
  --force) force=true;;
  -q) quiet=true;;
  -p) plugin=$2; shift;;
  *) plugin=$1;;
  esac
  shift
done # }}}
[[ -z $plugin ]] && echo "Missing plugin name." >/dev/stderr && exit 1
[[ ! -e $plugin ]] && echo "Plugin [$i] not found." >/dev/stderr && exit 1
$dry && dry=echo || dry=
[[ $plugin == */ ]] && plugin=${plugin/\/}
case $wtd in # {{{
INSTALL) # {{{
  if ! $force; then # {{{
    case $($0 -q --check -p $plugin; echo $?) in
    1) ;;
    0) echo "Plugin has to be uninstalled first." && exit 1;;
    2) echo "Plugin has to be initialized first." && exit 1;;
    *) echo "Other error" && exit 1;;
    esac
  fi # }}}
  if [[ -e .patches/$plugin ]]; then
    for p in $(command cd .patches/$plugin; find . -name \*.patch); do
      [[ -z $dry ]] \
        && patch $plugin/${p%.patch} <.patches/$plugin/$p \
        || echo "patch $plugin/$p <.patches/$plugin/$p"
    done
  fi ;; # }}}
esac # }}}
for i in $(command cd $plugin; ls); do # {{{
  [[ ! -d $plugin/$i ]] && continue
  case $i in # {{{
  test | registry) continue;;
  esac # }}}
  case $wtd in # {{{
  INSTALL) # {{{
    if [[ -z $dry ]] || ! $quiet; then
      $dry rsync $RSYNC_DEFAULT_PARAMS $plugin/$i $VIM_EXE
    fi ;; # }}}
  UNINSTALL) # {{{
    for j in $(command cd $plugin/$i; find . -type f); do
      [[ ! -e $VIM_EXE/$i/$j ]] && continue
      ss1="$(cd $VIM_EXE; find $i/$j -type f | xargs -n1 shasum 2>/dev/null)"
      ss2="$(cd $plugin; find $i/$j -type f | xargs -n1 shasum)"
      if [[ ${ss1%% *} == ${ss2%% *} ]]; then
        if [[ -z $dry ]] || ! $quiet; then
          $dry rm -rf $VIM_EXE/$i/$j
        fi
      else
        ! $quiet && echo "! ShaSums differ for ${ss2#* }, not removed."
        $show_diff && { echo -e "$i/$j\n"; colordiff -y --suppress-common-lines {$VIM_EXE,$plugin}/$i/$j; } | less
        list+="$VIM_EXE/${ss2##* }\n"
      fi
    done ;; # }}}
  CHECK) # {{{
    installed=
    for j in $(command cd $plugin/$i; find . -type f); do
      [[ -z $installed ]] && installed=false
      [[ -e $VIM_EXE/$i/$j ]] && installed=true && break
    done
    if [[ -z $installed ]]; then
      ! $quiet && echo "Plugin not initialized"
      exit 2
    elif $installed; then
      ! $quiet && echo "Plugin installed."
      exit 0
    else
      ! $quiet && echo "Plugin not installed."
      exit 1
    fi
    ;; # }}}
  esac # }}}
done # }}}
case $wtd in # {{{
INSTALL | UNINSTALL) # {{{
  if [[ -z $dry ]] || ! $quiet; then
    $dry _vim -c "\":helptags $VIM_EXE/doc/\"" -c ":q"
  fi ;;& # }}}
INSTALL) # {{{
  ;; # }}}
UNINSTALL) # {{{
  if [[ ! -z $list ]]; then
    ! $quiet && echo -e "\nSome files left:"
    echo -e $list | sed '/^$/d'
    ! $quiet && echo -e "Compare them with references for local modifications, store in .patches/$plugin/ if relevant.\n"
    exit 1
  fi
  exit 0;; # }}}
esac # }}}

