#!/bin/bash

set -e
history="$HOME/.config/locate_history"

[ -f "$history" ] || touch "$history"

function filter-results {
  grep -Ev -e '/\.cache/' -e '\.lnk$' -e '/\.Trash-1000/' -e '/diffpatch/diary/' |
    sort |
    awk -v 'x=^$' '$0 ~ x {}; $0 !~ x {x = "^"$0"/"; print $0;}'
}

function open {
  basename -- "$1" >> "$history"
  if [[ "$1" == *".txt" ]]; then
    coproc subl "$1" >/dev/null 2>&1
  else
    coproc xdg-open "$1" >/dev/null 2>&1
  fi
}

if [ "$ROFI_RETV" = 0 ]; then
  # Initial call of script.
  tac "$history" | awk '!x[$0]++'
  grep -Pi '^locate [^-][^ ]*$' ~/.config/bash_history | cut -d' ' -f2 | sort | uniq
elif [ -e "$1" ]; then
  open "$1"
else
  results="$(locate --ignore-case --limit 2000 -- "$1" | filter-results)"
  if [ -z "$results" ]; then
    echo "Nothing found..."
  elif [ "$(wc -l <<<"$results")" == 1 ]; then
    open "$results"
  else
    echo "$results"
  fi
fi
