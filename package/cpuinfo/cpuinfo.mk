################################################################################
#
# cpuinfo
#
################################################################################

CPUINFO_VERSION = 8ce83db858065145192c97af90cb668ad72a12e9
CPUINFO_SITE = $(call github,pytorch,cpuinfo,$(CPUINFO_VERSION))
CPUINFO_LICENSE = BSD-2-Clause
CPUINFO_LICENSE_FILES = LICENSE
CPUINFO_INSTALL_STAGING = YES
CPUINFO_CONF_OPTS = \
	-DCPUINFO_BUILD_UNIT_TESTS=OFF \
	-DCPUINFO_BUILD_MOCK_TESTS=OFF \
	-DCPUINFO_BUILD_BENCHMARKS=OFF

$(eval $(cmake-package))
