## Ruby Image Processing Benchmark

- https://github.com/libvips/libvips
- https://github.com/ImageMagick/ImageMagick

### Setup

```bash
$ docker build -t ruby-img-process-benchmark .
$ docker run -v $(pwd):/usr/src/app -it ruby-img-process-benchmark bash

/usr/src/app# vips --version
vips-8.15.0

/usr/src/app# convert --version
Version: ImageMagick 6.9.11-60 Q16 aarch64 2021-01-25 https://imagemagick.org
Copyright: (C) 1999-2021 ImageMagick Studio LLC
License: https://imagemagick.org/script/license.php
Features: Cipher DPC Modules OpenMP(4.5)
Delegates (built-in): bzlib djvu fftw fontconfig freetype heic jbig jng jp2 jpeg lcms lqr ltdl lzma openexr pangocairo png tiff webp wmf x xml zlib
```

### Run

```bash
ruby benchmark.rb <image_path>
```

e.g.

```bash
root@42661d87fce3:/usr/src/app# file images/desktop.png
images/desktop.png: PNG image data, 1803 x 1008, 8-bit/color RGBA, non-interlaced
root@42661d87fce3:/usr/src/app# ruby benchmark.rb images/desktop.png
----------------------------------------
method: resize_to_fill!, args: [200, 200]
                                   user     system      total        real
ImageProcessing::MiniMagick    0.001311   0.001090   0.098654 (  0.077063)
ImageProcessing::vips          0.057199   0.012019   0.069218 (  0.066731)
Memory usage by ImageMagick:
  Total allocated: 17355 bytes
  Total retained: 120 bytes
Memory usage by libvips:
  Total allocated: 8907 bytes
  Total retained: 0 bytes
----------------------------------------
method: resize_to_fill!, args: [1080, 1080]
                                   user     system      total        real
ImageProcessing::MiniMagick    0.000608   0.001131   0.718277 (  0.632847)
ImageProcessing::vips          0.313796   0.033823   0.347619 (  0.230040)
Memory usage by ImageMagick:
  Total allocated: 17359 bytes
  Total retained: 120 bytes
Memory usage by libvips:
  Total allocated: 8907 bytes
  Total retained: 0 bytes
----------------------------------------
method: resize_to_fill!, args: [2000, 3000]
                                   user     system      total        real
ImageProcessing::MiniMagick    0.000055   0.001937   4.486634 (  3.777178)
ImageProcessing::vips          1.627803   0.057257   1.685060 (  0.898309)
Memory usage by ImageMagick:
  Total allocated: 17359 bytes
  Total retained: 120 bytes
Memory usage by libvips:
  Total allocated: 8907 bytes
  Total retained: 0 bytes
```

test
