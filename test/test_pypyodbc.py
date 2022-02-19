"""Unittests for pypyodbc.py."""

import datetime
import unittest
import pypyodbc


class TestGetType(unittest.TestCase):
    def test_valid_types(self):
        # TODO: add more types coverage.
        cases = (
            ('boolean', True, ('b',)),
            ('unicode', 'any string is unicode', ('u',)),
            ('unicode large 256', 'x' * 256, ('U', 2000)),
            ('unicode large 2500', 'x' * 2500, ('U', 6000)),
            ('int', 0, ('i',)),
            ('long', 2**31, ('l',)),
            ('long negative', -2**31-1, ('l',)),
            ('float', 1.1, ('f',)),
            ('datetime', datetime.datetime(2022, 2, 19), ('dt',)),
            ('date', datetime.date(2022, 2, 19), ('d',)),
            ('time', datetime.time(), ('t',)),
        )
        for name, input_type, expected in cases:
            with self.subTest(name=name):
                self.assertEqual(expected, pypyodbc.get_type(input_type))
