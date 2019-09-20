#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

BYROND=${BYROND:-$BINDIR/byrond}
BYRONCLI=${BYRONCLI:-$BINDIR/byron-cli}
BYRONTX=${BYRONTX:-$BINDIR/byron-tx}
BYRONQT=${BYRONQT:-$BINDIR/qt/byron-qt}

[ ! -x $BYROND ] && echo "$BYROND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
BTCVER=($($BYRONCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for byrond if --version-string is not set,
# but has different outcomes for bitcoin-qt and byron-cli.
echo "[COPYRIGHT]" > footer.h2m
$BYROND --version | sed -n '1!p' >> footer.h2m

for cmd in $BYROND $BYRONCLI $BYRONTX $BYRONQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BTCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BTCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
