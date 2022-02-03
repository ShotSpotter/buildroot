################################################################################
#
# perl-json-xs
#
################################################################################

PERL_JSON_XS_VERSION = 4.03
PERL_JSON_XS_SOURCE = JSON-XS-$(PERL_JSON_XS_VERSION).tar.gz
PERL_JSON_XS_SITE = $(BR2_CPAN_MIRROR)/authors/id/M/ML/MLEHMANN
PERL_JSON_XS_DEPENDENCIES = host-perl-canary-stability
PERL_JSON_XS_LICENSE = Artistic or GPL-1.0+
PERL_JSON_XS_LICENSE_FILES = COPYING
PERL_JSON_XS_DISTNAME = JSON-XS

$(eval $(perl-package))
