import unittest
import sys
sys.path.append('../cli/')
from json_to_csv import json_to_csv

class TestJsonToCsv(unittest.TestCase):
    def test_json_to_csv(self):
        try:
            self.assertEqual(json_to_csv({'a': 1, 'b': 2, 'c': 3}), [['a', 'b', 'c'], [1, 2, 3]])
            print("Success: json_to_csv({'a': 1, 'b': 2, 'c': 3}) = [['a', 'b', 'c'], [1, 2, 3]]")
        except Exception as e:
            print("Error: Exception raised -", str(e))

if __name__ == '__main__':
    unittest.main()
