telegram-systray-colored-icon
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Make colored iconset for Telegram Desktop.
idea and svg pictures were borrowed from 
https://github.com/alireza-amirsamimi/telegram_tray_icon

prerequisites:
~~~~~~~~~~~~~~

rsvg-convert (or inkscape) must be installed.

install:
sudo apt-get install librsvg2-bin
sudo apt-get install inkscape

prepare:
~~~~~~~~
edit RUN.sh and change value of `color` variable. 
  color values are in RRGGBB format

run RUN.sh
./RUN.sh
or 
verbose=1 ./RUN.sh

copy png-images from the output/<color>/ subdirectory 
to the /tdata/ticons/ subdirectory 
(somewhere in your Telegram Desktop profile directory)

