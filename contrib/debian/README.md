
Debian
====================
This directory contains files used to package byrond/byron-qt
for Debian-based Linux systems. If you compile byrond/byron-qt yourself, there are some useful files here.

## byron: URI support ##


byron-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install byron-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your byronqt binary to `/usr/bin`
and the `../../share/pixmaps/byron128.png` to `/usr/share/pixmaps`

byron-qt.protocol (KDE)

