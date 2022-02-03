################################################################################
#
# perl-common-sense
#
################################################################################

PERL_COMMON_SENSE_VERSION = 3.75
PERL_COMMON_SENSE_SOURCE = common-sense-$(PERL_COMMON_SENSE_VERSION).tar.gz
PERL_COMMON_SENSE_SITE = $(BR2_CPAN_MIRROR)/authors/id/M/ML/MLEHMANN
PERL_COMMON_SENSE_LICENSE = Artistic or GPL-1.0+
PERL_COMMON_SENSE_LICENSE_FILES = LICENSE
PERL_COMMON_SENSE_DISTNAME = common-sense

$(eval $(perl-package))
