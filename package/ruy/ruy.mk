################################################################################
#
# ruy
#
################################################################################

RUY_VERSION = 3286a34cc8de6149ac6844107dfdffac91531e72
RUY_SITE = $(call github,google,ruy,$(RUY_VERSION))
RUY_LICENSE = Apache-2.0
RUY_LICENSE_FILES = LICENSE
RUY_INSTALL_STAGING = YES
RUY_DEPENDENCIES = cpuinfo
RUY_CONF_OPTS = \
	-DCMAKE_POSITION_INDEPENDENT_CODE=ON \
	-DRUY_FIND_CPUINFO=ON \
	-DRUY_MINIMAL_BUILD=ON

$(eval $(cmake-package))
