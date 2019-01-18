from setuptools import setup

setup(name='matumap',
      version='0.1',
      description='Wrappers for running umap-learn in matlab',
      url='http://github.com/zekearneodo/matumap',
      author='Gagan Narula - Zeke Arneodo',
      author_email='ezequiel@ini.ethz.ch',
      license='MIT',
      packages=['matumap'],
      install_requires=['numpy',
                        'umap-learn>=0.3.7'],
      zip_safe=False)