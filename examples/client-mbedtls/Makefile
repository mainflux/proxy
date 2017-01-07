##
# Copyright (c) Project Iota
#
# uCbor is licensed under an Apache license, version 2.0 license.
# All rights not explicitly granted in the Apache license, version 2.0 are reserved.
# See the included LICENSE file for more details.
##

SRCDIR = src
INCDIR = inc
OBJDIR = obj
LIBDIR = lib
LIBINCDIRS = $(LIBDIR)/mbedtls/include

SRC = $(wildcard $(SRCDIR)/*.c)
INC = $(wildcard $(INCDIR)/*.h)
 
OBJ = $(SRC:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
TARGET = client-mbedtls
 
CC := gcc
CFLAGS = -Wall -W -O
LIBS =
LDFLAGS = $(LIBS:%=-l%)

###
# MbedTLS
###
MBEDTLS_LIBDIR = $(LIBDIR)/mbedtls/library
# Order is important
MBEDTLS_LIBS = libmbedtls.a libmbedx509.a libmbedcrypto.a
ARCHS = $(MBEDTLS_LIBS:%=$(MBEDTLS_LIBDIR)/%)
 
$(TARGET) : $(OBJ) mbedtls
	$(CC) $(LDFLAGS) -o $@ $< $(ARCHS)
 
$(OBJ): $(OBJDIR)/%.o : $(SRCDIR)/%.c
	mkdir -p $(OBJDIR)
	$(CC) $(CFLAGS) -I$(INCDIR) $(LIBINCDIRS:%=-I%) -c -o $@ $<

mbedtls:
	make -C $(LIBDIR)/mbedtls lib
 
.PHONY : clean
clean :
	rm -rf $(TARGET) $(OBJDIR)
	make -C $(LIBDIR)/mbedtls clean
