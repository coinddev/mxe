# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := harfbuzz
$(PKG)_WEBSITE  := https://wiki.freedesktop.org/www/Software/HarfBuzz/
$(PKG)_DESCR    := HarfBuzz
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.7.2
$(PKG)_CHECKSUM := a790585e35c1a87f0dcc23580c84b7cc2324e6f67a2946178d278c2a36c790cb
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := https://www.freedesktop.org/software/$(PKG)/release/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc cairo freetype-bootstrap glib icu4c

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://cgit.freedesktop.org/harfbuzz/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?h=[^0-9]*\\([0-9.]*\\)'.*,\\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    # mman-win32 is only a partial implementation
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        ac_cv_header_sys_mman_h=no \
        LIBS='-lstdc++'
    $(MAKE) -C '$(1)' -j '$(JOBS)' install
endef
