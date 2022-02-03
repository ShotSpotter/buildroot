from tests.package.test_perl import TestPerlBase


class TestPerlJSONXS(TestPerlBase):
    """
    package:
        JSON-XS   XS
    direct dependencies:
        Types-Serialiser
        common-sense
    """

    config = TestPerlBase.config + \
        """
        BR2_PACKAGE_PERL=y
        BR2_PACKAGE_PERL_JSON_XS=y
        """

    def test_run(self):
        self.login()
        self.module_test("JSON::XS")
