FROM ubuntu:16.04 as builder

ENV LC_ALL en_US.UTF-8

ADD . /tmp/

RUN apt-get update \
	&& apt-get install -qy apt-utils \
	&& apt-get -qy install locales \
    && locale-gen --no-purge en_US.UTF-8 \
	&& apt-get install -qy \
	git \
	build-essential \
	gawk \
	pkg-config \
	gettext \
	automake \
	autoconf \
	autopoint \
	libtool \
	bison \
	flex \
	zlib1g-dev \
	libgmp3-dev \
	libmpfr-dev \
	libmpc-dev \
	texinfo \
	mc \
	libncurses5-dev \
	nano \
	vim \
  	autopoint \
	gperf \
	python-docutils \
	module-init-tools \
	&& git clone https://bitbucket.org/padavan/rt-n56u.git /opt/rt-n56u \
	&& sed -i 's/sudo//g' /opt/rt-n56u/trunk/tools/depmod.sh \
	&& sed -i 's/sudo//g' /opt/rt-n56u/trunk/user/scripts/makedevlinks \
	&& sed -i 's/sudo//g' /opt/rt-n56u/trunk/vendors/Ralink/MT7620/Makefile \
	&& cp /tmp/config/ac54u_base.config /opt/rt-n56u/trunk/.config \
	&& cp /tmp/config/board.h /opt/rt-n56u/trunk/configs/boards/RT-AC54U/board.h \
	&& cp /tmp/config/kernel-3.4.x.config /opt/rt-n56u/trunk/configs/boards/RT-AC54U/kernel-3.4.x.config \
	&& cp /tmp/config/board.mk /opt/rt-n56u/trunk/configs/boards/RT-AC54U/board.mk \
	&& cp /tmp/config/defaults.h /opt/rt-n56u/trunk/user/shared/defaults.h \
	&& cp /tmp/config/CN.dict /opt/rt-n56u/trunk/user/www/dict/ \
	&& cp /tmp/config/Makefile /opt/rt-n56u/trunk/user/www/ \
	&& cp /tmp/Stock_v21.4.6.10/MT7612E_EEPROM.bin /opt/rt-n56u/trunk/vendors/Ralink/MT7620/MT7612E_EEPROM.bin \
	&& cp /tmp/Stock_v21.4.6.10/MT7620_AP_2T2R-4L_V15.BIN /opt/rt-n56u/trunk/vendors/Ralink/MT7620/MT7620_AP_2T2R-4L_external_LNA_external_PA_V15.bin \
	&& cd /opt/rt-n56u/toolchain-mipsel \
	&& ./clean_sources \
	&& ./build_toolchain_3.4.x \
	&& cd /opt/rt-n56u/trunk \
	&& ./clear_tree \
	&& ./build_firmware \
	&& mkdir -p /root/images \
	&& cp /opt/rt-n56u/trunk/images/*.trx /root/images

FROM alpine

VOLUME [ "/data" ]

WORKDIR /root/images

COPY --from=builder /root/images /root/images
