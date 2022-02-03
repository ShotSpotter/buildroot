################################################################################
#
# perl-types-serialiser
#
################################################################################

PERL_TYPES_SERIALISER_VERSION = 1.01
PERL_TYPES_SERIALISER_SOURCE = Types-Serialiser-$(PERL_TYPES_SERIALISER_VERSION).tar.gz
PERL_TYPES_SERIALISER_SITE = $(BR2_CPAN_MIRROR)/authors/id/M/ML/MLEHMANN
PERL_TYPES_SERIALISER_LICENSE = Artistic or GPL-1.0+
PERL_TYPES_SERIALISER_LICENSE_FILES = COPYING
PERL_TYPES_SERIALISER_DISTNAME = Types-Serialiser

$(eval $(perl-package))
