################################################################################
#
# perl-canary-stability
#
################################################################################

PERL_CANARY_STABILITY_VERSION = 2013
PERL_CANARY_STABILITY_SOURCE = Canary-Stability-$(PERL_CANARY_STABILITY_VERSION).tar.gz
PERL_CANARY_STABILITY_SITE = $(BR2_CPAN_MIRROR)/authors/id/M/ML/MLEHMANN
PERL_CANARY_STABILITY_LICENSE = Artistic or GPL-1.0+
PERL_CANARY_STABILITY_LICENSE_FILES = COPYING
PERL_CANARY_STABILITY_DISTNAME = Canary-Stability

$(eval $(host-perl-package))
