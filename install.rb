#!/usr/bin/env ruby
#
## from http://errtheblog.com/posts/89-huba-huba
#
home = File.expand_path('~')

Dir['etc/*'].each do |file|
  next if file =~ /install|readme/i
  target = File.join(home, ".#{File.basename(file)}")
  puts "Linking #{File.expand_path file} to #{target}"
  puts `ln -svfn #{File.expand_path file} #{target}`
end
