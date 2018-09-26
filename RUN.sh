#!/bin/bash
# edit value for colors (if need)
# launch this script
# copy generated png files
#    from 'colorized/<color>/' 
#    to 'tdata/ticons/' folder
#    (can be found in 
# ~/snap/telegram-desktop/current/.local/share/TelegramDesktop/tdata/ticons/
# .TelegramDesktop/tdata/ticons/
#

# colors="FF8C00 6495ED 00FF00 FF69B4"
: ${colors:="FF4500 FF8C00 FFA500 6495ED 00BFFF 202020 F5F5F5 FFFFE0"}
: ${verbose:=0}
: ${out:="./output"}

tmpsvg="/tmp/tmp.svg"

icon_file="telegram.svg"
gray_file="telegram_gray.svg"
red_file="telegram_red.svg"

### pre-check ###

if which rsvg-convert >/dev/null ; then
  converter="rsvg-convert -w 22 -h 22 -f png -o"
elif which inkscape >/dev/null ; then
  converter="inkscape -z -w 22 -h 22 -e"
# TODO: add more elif if need
else
  cat 1>&2 <<_EOM_
neither rsvg-convert nor inkscape found.
install one (or both) of them:
sudo apt-get install librsvg2-bin # for rsvg-convert, faster
sudo apt-get install inkscape     # for inkscape, slower but
                                  #   you also can become an artist =)
_EOM_
  exit 1
fi


### mkicon ###

mkicon() {
  local input="$1"
  local output="$2"
  local color="$3"
  local countval="$4"
  sed -e "s/\\#eff0f1/\\#$color/" -e "s/>999</>$countval</" <"$input" >"$tmpsvg"
  # inkscape -z -e "$output" -w 22 -h 22 "$tmpsvg"  2>/dev/null
  # rsvg-convert -w 22 -h 22 -f png -o "$output" "$tmpsvg"
  $converter "$output" "$tmpsvg"
  rm "$tmpsvg"
}

### main ###

test -d "$out" && rm -rf "$out"
mkdir -p "$out"

for color in $colors ; do
  dir="$out/$color"
  mkdir -p "$dir"
  mkicon telegram.svg "$dir/ico_22_0.png" "$color" ""
  cp "$dir/ico_22_0.png" "$dir/icomute_22_0.png"
  for n in {1..1100} ; do
    test $verbose -ne 0 && \
        printf '\rcreating icon for color %s [%d of 1100] ...' $color $n
    if [ $n -gt 999 ]; then
      s=`printf '*%03d' $n`
    else
      s=`printf '%02d' $n`
    fi
    mkicon telegram_gray.svg "$dir/icomute_22_$n.png" "$color" "$s"
    mkicon telegram_red.svg "$dir/ico_22_$n.png" "$color" "$s"
  done
  test $verbose -ne 0 && \
    printf '\ricons for color %s created.                    \n' $color
done
test $verbose -ne 0 && echo " done!"
