#! /usr/bin/bash
set -e

# -std=gnu99: src/common/stddecl.h has `typedef enum { false, true } bool;`
# for pre-C99 compilers without <stdbool.h>. Newer clang (macOS's default C
# standard has advanced past C99) already treats false/true as reserved,
# breaking that typedef -- pin an explicit older standard so the shim works
# on every platform instead of whatever the local compiler defaults to.
export CFLAGS="-fPIC -fcommon -std=gnu99"

# Bundled config.sub/config.guess predate aarch64 triplets -- replace with
# the current ones from the gnuconfig package before configuring.
for f in config.sub config.guess; do
  find . -name "$f" -exec cp "$BUILD_PREFIX/share/gnuconfig/$f" {} \;
done

./configure --prefix=$PREFIX

make
make install
