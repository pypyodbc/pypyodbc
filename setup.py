try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

import pypyodbc

setup(
    name='pypyodbc',
    version=pypyodbc.version,
    description='A Pure Python ctypes ODBC module.',
    author='jiangwen365',
    author_email='jiangwen365@gmail.com',
    url='https://github.com/pypyodbc/pypyodbc',
    py_modules=['pypyodbc'],
    long_description=
        "A Pure Python ctypes ODBC module compatible with PyPy and almost"
        " totally same usage as pyodbc.",
    classifiers=[
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python",
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        'Natural Language :: English',
        'Operating System :: MacOS :: MacOS X',
        'Operating System :: Microsoft :: Windows',
        'Operating System :: POSIX',
        'Operating System :: POSIX :: Linux',
        'Operating System :: Unix',
    ],
    keywords='Python, Database, Interface, ODBC, PyPy',
    license='MIT',
)
