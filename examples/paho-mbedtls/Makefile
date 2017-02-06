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
LIBINCDIRS = $(LIBDIR)/mbedtls/include $(LIBDIR)/paho-embedded/MQTTPacket/src \
			 $(LIBDIR)/paho-embedded/MQTTClient-C/src $(LIBDIR)/paho-embedded/MQTTClient-C/src/linux

SRC = $(wildcard $(SRCDIR)/*.c)
INC = $(wildcard $(INCDIR)/*.h)
OBJ = $(SRC:$(SRCDIR)/%.c=$(OBJDIR)/%.o)

CC := gcc
#CFLAGS = -Wall -W -O
LIBS =
LDFLAGS = $(LIBS:%=-l%)

TARGET = client-paho-embedded

###
# MbedTLS
###
MBEDTLS_LIBDIR = $(LIBDIR)/mbedtls/library
# Order is important
MBEDTLS_LIBS = libmbedtls.a libmbedx509.a libmbedcrypto.a
ARCHS = $(MBEDTLS_LIBS:%=$(MBEDTLS_LIBDIR)/%) $(LIBDIR)/paho-embedded/libpaho-embedded.a
 
$(TARGET) : $(OBJ) mbedtls paho-embedded
	$(CC) $(LDFLAGS) -o $@ $< $(ARCHS)
 
$(OBJ): $(OBJDIR)/%.o : $(SRCDIR)/%.c
	mkdir -p $(OBJDIR)
	$(CC) $(CFLAGS) -I$(INCDIR) $(LIBINCDIRS:%=-I%) -c -o $@ $<

mbedtls:
	make -C $(LIBDIR)/mbedtls -j 16 lib

paho-embedded:
	make -C $(LIBDIR)/paho-embedded -f makefile-embedded-static
 
.PHONY : clean
clean :
	rm -rf $(TARGET) $(OBJDIR)
	make -C $(LIBDIR)/mbedtls clean
	make -C $(LIBDIR)/paho-embedded -f makefile-embedded-static clean

