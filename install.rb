#!/usr/bin/env ruby
#
## from http://errtheblog.com/posts/89-huba-huba
#
home = File.expand_path('~')

Dir['etc/*'].each do |file|
  next if file =~ /install|readme/i
  target = File.join(home, ".#{File.basename(file)}")
  puts `ln -svf #{File.expand_path file} #{target}`
end

# git push on commit
`echo 'git push' > .git/hooks/post-commit`
`chmod 755 .git/hooks/post-commit`
