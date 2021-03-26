#!/usr/bin/env bash
cd $HOME/Spyder
rm -rf $HOME/.telegram-cli
install() {
sudo chmod +x tg
chmod +x Spyder
chmod +x tk
./tk
}
if [ "$1" = "ins" ]; then
ins
fi
chmod +x install.sh
lua start.lua
