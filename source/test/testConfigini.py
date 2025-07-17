import unittest
import os
import configparser

class TestConfigINI(unittest.TestCase):

    def setUp(self):
        test_dir = os.path.dirname(__file__)
        self.config_file = os.path.join(test_dir, 'testConfig.ini')
        self.cfg = configparser.ConfigParser()
        self.cfg.read(self.config_file)

    def test_sections_exist(self):
        # test if [TEST] and [THRESHOLD] sections exist
        self.assertIn('TEST', self.cfg)
        self.assertIn('THRESHOLD', self.cfg)

    def test_required_test_keys(self):
        # Check if all required keys in [TEST] section exist
        expected_keys = ['host', 'ixos_version', 'tester', 'test_ports', 'test_mode',
                         'test_duration', 'test_frameSize_list', 'test_speed',
                         'serdes', 'wait_time_before_startTest']
        for key in expected_keys:
            self.assertIn(key, self.cfg['TEST'], f"Missing [TEST] key: {key}")

    def test_required_threshold_keys(self):
        # Check if all required keys in [THRESHOLD] section exist
        # expected_keys = ['pre_fec_standard', 'post_fec_standard']
        self.assertIn('pre_fec_standard', self.cfg['THRESHOLD'])
        self.assertIn('post_fec_standard', self.cfg['THRESHOLD'])

    def test_ip_format(self):
        # Check if the host IP is in valid format (ipv4)
        host = self.cfg['TEST']['host']
        self.assertRegex(host, r'^\d{1,3}(\.\d{1,3}){3}$', "Host is not a valid IP")

    def test_numeric_values(self):
        # Check if test_duration and wait_time_before_startTest are numeric
        self.assertTrue(self.cfg['TEST']['test_duration'].isdigit())
        self.assertTrue(self.cfg['TEST']['wait_time_before_startTest'].isdigit())

    def test_threshold_formats(self):
        # Check if pre_fec_standard and post_fec_standard are valid floats
        pre = self.cfg['THRESHOLD']['pre_fec_standard']
        post = self.cfg['THRESHOLD']['post_fec_standard']
        try:
            float(pre)
            float(post)
        except ValueError:
            self.fail("FEC thresholds should be valid floats")

    def test_tester_enum(self):
        # Check if tester is one of the allowed values
        allowed = ['SERT100G', 'AresONE800MDUAL']
        self.assertIn(self.cfg['TEST']['tester'], allowed, "Invalid tester type")

if __name__ == '__main__':
    unittest.main()
