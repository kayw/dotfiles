#!/bin/sh

pacman -Syuu
pacman -Rscn $(pacman -Qtdq)
pacman -Scc
pacman-optimize && sync

exit 0
