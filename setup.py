try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

setup(
    name='pypyodbc',
    version='0.0.0a0', # actual version injected at release build time
    description='A Pure Python ctypes ODBC module',
    author='jiangwen365',
    author_email='jiangwen365@gmail.com',
    url='https://github.com/jiangwen365/pypyodbc',
    py_modules=['pypyodbc'],
    long_description="""
      A Pure Python ctypes ODBC module compatible with PyPy and almost totally same usage as pyodbc
      """,
    classifiers=[
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python",
        "Development Status :: 4 - Beta",
    ],
    keywords='Python, Database, Interface, ODBC, PyPy',
    license='MIT',
)
