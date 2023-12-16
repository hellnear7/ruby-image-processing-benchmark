require 'image_processing/vips'
require 'image_processing/mini_magick'
require 'benchmark'
require 'memory_profiler'

# 使用する画像のパスを設定します。
image_path = ARGV[0]

def process_with_vips(image_path, method, args)
  pipeline = ImageProcessing::Vips.source(image_path)
  pipeline.send(method, *args)
end

def process_with_mini_magick(image_path, method, args)
  pipeline = ImageProcessing::MiniMagick.source(image_path)
  pipeline.send(method, *args)
end

def report(method, args, image_path)
  puts "----------------------------------------"
  puts "method: #{method}, args: #{args}"
  run_times = 1
  Benchmark.bm(28) do |x|
    x.report("ImageProcessing::MiniMagick"){ run_times.times { process_with_mini_magick(image_path, method, args) } }
    x.report("ImageProcessing::vips"){ run_times.times { process_with_vips(image_path, method, args) } }
  end
  imagemagick_report = MemoryProfiler.report { process_with_mini_magick(image_path, method, args) }
  vips_report = MemoryProfiler.report { process_with_vips(image_path, method, args) }

  puts "Memory usage by ImageMagick:"
  puts "  Total allocated: #{imagemagick_report.total_allocated_memsize} bytes"
  puts "  Total retained: #{imagemagick_report.total_retained_memsize} bytes"

  puts "Memory usage by libvips:"
  puts "  Total allocated: #{vips_report.total_allocated_memsize} bytes"
  puts "  Total retained: #{vips_report.total_retained_memsize} bytes"
end


report(:resize_to_fill!, [200, 200], image_path)
report(:resize_to_fill!, [1080, 1080], image_path)
report(:resize_to_fill!, [2000, 3000], image_path)
