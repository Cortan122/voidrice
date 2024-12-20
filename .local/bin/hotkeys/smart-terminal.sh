#!/bin/sh

set -e

send_key () {
  xdotool key --clearmodifiers Super+Shift+T
}

start_term () {
  (
    sleep 0.2
    i3-msg '[class="st"] focus'
  ) &
  exec i3-sensible-terminal
}

if ! name="$(xdotool getactivewindow getwindowclassname)"; then
  [ "$1" = "press" ] && start_term
  exit
fi

case "$1" in
  press)
    case "$name" in
      Thunar|VSCodium|VSCode) ;;
      *) start_term ;;
    esac ;;
  release)
    case "$name" in
      Thunar|VSCodium|VSCode) send_key ;;
      *) ;;
    esac ;;
  *) start_term ;;
esac
