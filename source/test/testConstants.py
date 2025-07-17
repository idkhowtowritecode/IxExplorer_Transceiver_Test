import unittest
import sys
import os

# Add root to path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..')))

from constants import DEBUG, timer, prbsPattern

class TestConstants(unittest.TestCase):
    # Test the prbsPattern class for txPrbsPattern
    def test_prbs_tx_patterns(self):
        expected_keys = ['PRBS-7', 'PRBS-31INV']
        for key in expected_keys:
            self.assertIn(key, prbsPattern.txPrbsPattern)
            self.assertIsInstance(prbsPattern.txPrbsPattern[key], int)
    # Test the prbsPattern class for rxPrbsPattern
    def test_prbs_rx_patterns(self):
        self.assertIn('Auto', prbsPattern.rxPrbsPattern)
        self.assertEqual(prbsPattern.rxPrbsPattern['Auto'], 32)
    # Test the lockLostIcon mapping
    def test_lock_lost_icon_values(self):
        self.assertEqual(prbsPattern.lockLostIcon[0], 'Yes')
        self.assertEqual(prbsPattern.lockLostIcon[2], 'No')
        self.assertEqual(prbsPattern.lockLostIcon[3], 'Pre')
    # Test the timer decorator
    def test_timer_decorator_behavior(self):
        @timer
        def dummy_func():
            return 42
        
        result = dummy_func()
        self.assertEqual(result, 42)
    # Test the DEBUG flag
    def test_debug_flag_exists(self):
        self.assertIsInstance(DEBUG, bool)

if __name__ == '__main__':
    unittest.main()
