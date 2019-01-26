set __cyber_toast_color_orange ff2600
set __cyber_toast_color_blue 00beff
set __cyber_toast_color_green 00faac
set __cyber_toast_color_yellow fef96a
set __cyber_toast_color_pink ff95ee
set __cyber_toast_color_grey e5e5e5
set __cyber_toast_color_white feffff
set __cyber_toast_color_purple de95ff
set __cyber_toast_color_lilac 85cbfd

function __cyber_toast_color_echo
  set_color $argv[1]
  if test (count $argv) -eq 2
    echo -n $argv[2]
  end
end

function __cyber_toast_current_folder
  if test $PWD = '/'
    echo -n '/'
  else
    echo -n $PWD | grep -o -E '[^\/]+$'
  end
end

function __cyber_toast_git_status_codes
  echo (git status --porcelain ^/dev/null | sed -E 's/(^.{3}).*/\1/' | tr -d ' \n')
end

function __cyber_toast_git_branch_name
  echo (git rev-parse --abbrev-ref HEAD ^/dev/null)
end

function __cyber_toast_rainbow
  if echo $argv[1] | grep -q -e $argv[3]
    __cyber_toast_color_echo $argv[2] "彡ミ"
  end
end

function __cyber_toast_git_status_icons
  set -l git_status (__cyber_toast_git_status_codes)

  __cyber_toast_rainbow $git_status $__cyber_toast_color_pink 'D'
  __cyber_toast_rainbow $git_status $__cyber_toast_color_orange 'R'
  __cyber_toast_rainbow $git_status $__cyber_toast_color_white 'C'
  __cyber_toast_rainbow $git_status $__cyber_toast_color_green 'A'
  __cyber_toast_rainbow $git_status $__cyber_toast_color_blue 'U'
  __cyber_toast_rainbow $git_status $__cyber_toast_color_lilac 'M'
  __cyber_toast_rainbow $git_status $__cyber_toast_color_grey '?'
end

function __cyber_toast_git_status
  # In git
  if test -n (__cyber_toast_git_branch_name)

    __cyber_toast_color_echo $__cyber_toast_color_blue " git"
    __cyber_toast_color_echo $__cyber_toast_color_white ":"(__cyber_toast_git_branch_name)

    if test -n (__cyber_toast_git_status_codes)
      __cyber_toast_color_echo $__cyber_toast_color_pink ' ●'
      __cyber_toast_color_echo $__cyber_toast_color_white ' [^._.^]ﾉ'
      __cyber_toast_git_status_icons
    else
      __cyber_toast_color_echo $__cyber_toast_color_green ' ○'
    end
  end
end

function fish_prompt
  __cyber_toast_color_echo $__cyber_toast_color_blue "# "
  __cyber_toast_color_echo $__cyber_toast_color_purple (__cyber_toast_current_folder)
  __cyber_toast_git_status
  echo
  __cyber_toast_color_echo $__cyber_toast_color_pink "\$ "
end
