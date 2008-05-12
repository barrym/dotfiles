#!/usr/bin/ruby
require 'rubygems'
require 'irb/completion'
require 'irb/ext/save-history'
require 'pp'
require 'what_methods'

ANSI_BLACK = "\033[0;30m"
ANSI_GRAY = "\033[1;30m"
ANSI_LGRAY = "\033[0;37m"
ANSI_WHITE = "\033[1;37m"
ANSI_RED ="\033[0;31m"
ANSI_LRED = "\033[1;31m"
ANSI_GREEN = "\033[0;32m"
ANSI_LGREEN = "\033[1;32m"
ANSI_BROWN = "\033[0;33m"
ANSI_YELLOW = "\033[1;33m"
ANSI_BLUE = "\033[0;34m"
ANSI_LBLUE = "\033[1;34m"
ANSI_PURPLE = "\033[0;35m"
ANSI_LPURPLE = "\033[1;35m"
ANSI_CYAN = "\033[0;36m"
ANSI_LCYAN = "\033[1;36m"

ANSI_BACKBLACK = "\033[40m"
ANSI_BACKRED = "\033[41m"
ANSI_BACKGREEN = "\033[42m"
ANSI_BACKYELLOW = "\033[43m"
ANSI_BACKBLUE = "\033[44m"
ANSI_BACKPURPLE = "\033[45m"
ANSI_BACKCYAN = "\033[46m"
ANSI_BACKGRAY = "\033[47m"

ANSI_RESET = "\033[0m"
ANSI_BOLD = "\033[1m"
ANSI_UNDERSCORE = "\033[4m"
ANSI_BLINK = "\033[5m"
ANSI_REVERSE = "\033[7m"
ANSI_CONCEALED = "\033[8m"

XTERM_SET_TITLE = "\033]2;"
XTERM_END = "\007"
ITERM_SET_TAB = "\033]1;"
ITERM_END = "\007"
SCREEN_SET_STATUS = "\033]0;"
SCREEN_END = "\007"

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history" 
IRB.conf[:PROMPT_MODE]  = :SIMPLE
IRB.conf[:AUTO_INDENT] = true

# Just for Rails...
if rails_env = ENV['RAILS_ENV']
  rails_root = File.basename(Dir.pwd)
  IRB.conf[:PROMPT] ||= {}
  IRB.conf[:PROMPT][:RAILS] = {
    :PROMPT_I => "#{ANSI_BACKBLUE + ANSI_YELLOW} #{ENV['RAILS_ENV']}#{ANSI_RESET} >",
    :PROMPT_S => "#{rails_root}* ",
    :PROMPT_C => "#{rails_root}? ",
    :RETURN   => "=> %s\n" 
  }
  IRB.conf[:PROMPT_MODE] = :RAILS

  # Called after the irb session is initialized and Rails has
  # been loaded (props: Mike Clark).
  IRB.conf[:IRB_RC] = Proc.new do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Base.instance_eval { alias :[] :find }
    
    module ActiveRecord
      class Base
        def self.first(*args)
          options = args.extract_options!
          find_initial(options)
        end
        
        def self.all(*args)
          options = args.extract_options!
          find_every(options)
        end
      end
    end
    
  end
end
