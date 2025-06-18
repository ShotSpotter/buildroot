################################################################################
#
# tensorflow-lite
#
################################################################################

TENSORFLOW_LITE_VERSION = 2.18.0
TENSORFLOW_LITE_SITE =  $(call github,tensorflow,tensorflow,v$(TENSORFLOW_LITE_VERSION))
TENSORFLOW_LITE_INSTALL_STAGING = YES
TENSORFLOW_LITE_LICENSE = Apache-2.0
TENSORFLOW_LITE_LICENSE_FILES = LICENSE
TENSORFLOW_LITE_SUBDIR = tensorflow/lite
TENSORFLOW_LITE_SUPPORTS_IN_SOURCE_BUILD = NO
TENSORFLOW_LITE_DEPENDENCIES += \
	host-pkgconf \
	host-flatbuffers \
	cpuinfo \
	eigen \
	farmhash \
	fft2d \
	flatbuffers \
	flatcc \
	gemmlowp \
	libabseil-cpp \
	neon-2-sse \
	pthreadpool


TENSORFLOW_LITE_CONF_OPTS = \
	-DTFLITE_HOST_TOOLS_DIR=$(HOST_DIR) \
	-DProtobuf_PROTOC_EXECUTABLE=$(HOST_DIR)/bin/protoc \
	-Dabsl_DIR=$(STAGING_DIR)/usr/lib/cmake/absl \
	-DBUILD_SHARED_LIBS=ON \
	-DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -I$(STAGING_DIR)/usr/include/gemmlowp" \
	-DCMAKE_FIND_PACKAGE_PREFER_CONFIG=ON \
	-DCMAKE_POSITION_INDEPENDENT_CODE=ON \
	-DEigen3_DIR=$(STAGING_DIR)/usr/share/eigen3/cmake \
	-DFETCHCONTENT_FULLY_DISCONNECTED=ON \
	-DFETCHCONTENT_QUIET=OFF \
	-DFFT2D_SOURCE_DIR=$(STAGING_DIR)/usr/include/fft2d \
	-DFlatBuffers_DIR=$(STAGING_DIR)/usr/lib/cmake/flatbuffers \
	-DNEON_2_SSE_DIR=$(STAGING_DIR)/usr/lib/cmake/NEON_2_SSE \
	-DSYSTEM_FARMHASH=ON \
	-DTFLITE_ENABLE_EXTERNAL_DELEGATE=ON \
	-DTFLITE_ENABLE_GPU=OFF \
	-DTFLITE_ENABLE_INSTALL=ON \
	-DTFLITE_ENABLE_MMAP=ON \
	-DTFLITE_ENABLE_NNAPI=OFF

ifeq ($(BR2_PACKAGE_RUY),y)
TENSORFLOW_LITE_DEPENDENCIES += ruy
TENSORFLOW_LITE_CONF_OPTS += -DTFLITE_ENABLE_RUY=ON
else
TENSORFLOW_LITE_CONF_OPTS += -DTFLITE_ENABLE_RUY=OFF
endif

ifeq ($(BR2_PACKAGE_XNNPACK),y)
TENSORFLOW_LITE_DEPENDENCIES += xnnpack
TENSORFLOW_LITE_CONF_OPTS += -DTFLITE_ENABLE_XNNPACK=ON -Dxnnpack_POPULATED=ON
else
TENSORFLOW_LITE_CONF_OPTS += -DTFLITE_ENABLE_XNNPACK=OFF
endif

ifeq ($(BR2_PACKAGE_TENSORFLOW_LITE_EXAMPLES),y)
# currently there is only one example, label_image (mobilenet)
# This example is broken in v2.15.0, v2.17.0, see
# https://github.com/tensorflow/tensorflow/issues/62214
# Example is not shipped; it is located in
# $(TENSORFLOW_LITE_SRCDIR)/buildroot-build/examples/label_image
TENSORFLOW_LITE_CONF_OPTS += -DTFLITE_ENABLE_LABEL_IMAGE=ON
TENSORFLOW_LITE_DEPENDENCIES += protobuf
else
TENSORFLOW_LITE_CONF_OPTS += -DTFLITE_ENABLE_LABEL_IMAGE=OFF
endif

# CMake requires that dependencies for this tool be satisfied,
# but it is not built as part of make all. Unresolved.
ifeq ($(BR2_PACKAGE_TENSORFLOW_LITE_BENCHMARK_TOOL),y)
TENSORFLOW_LITE_CONF_OPTS += -DTFLITE_BENCHMARK_MODEL=ON
TENSORFLOW_LITE_DEPENDENCIES += protobuf
else
TENSORFLOW_LITE_CONF_OPTS += -DTFLITE_BENCHMARK_MODEL=OFF
endif


# Regenerate schemas with FlatBuffers flatcc to work around Google's hyper-specific version checking.
# Can't fix tensorflow/lite/acceleration/configuration/configuration_generated.h this way, no .fbs file.
TENSORFLOW_LITE_RECOMPILE_SCHEMAS = \
$(HOST_DIR)/bin/flatc --cpp --gen-object-api -o $(TENSORFLOW_LITE_SRCDIR)/../compiler/mlir/lite/schema \
$(TENSORFLOW_LITE_SRCDIR)/../compiler/mlir/lite/schema/conversion_metadata.fbs && \
$(HOST_DIR)/bin/flatc --cpp --gen-object-api -o $(TENSORFLOW_LITE_SRCDIR)/../compiler/mlir/lite/schema \
$(TENSORFLOW_LITE_SRCDIR)/../compiler/mlir/lite/schema/schema.fbs

TENSORFLOW_LITE_POST_PATCH_HOOKS += TENSORFLOW_LITE_RECOMPILE_SCHEMAS

$(eval $(cmake-package))
