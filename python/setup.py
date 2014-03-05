from distutils.core import setup, Extension

fizzmodule = Extension(
    'fizzmodule', 
    sources=['fizzmodule.c'],
    extra_objects=['../fizzy.o'],
    extra_compile_args=['-m32'],
    extra_link_args=['-m32 -read_only_relocs suppress'])

setup(
    name='fizzmodule',
    version='1.0',
    description='FizzBuzz test',
    ext_modules=[fizzmodule],
)
