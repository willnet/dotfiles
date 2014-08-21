require 'rubygems'
require 'irb/completion'

IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:EVAL_HISTORY] = 30
IRB.conf[:AUTO_INDENT] = true

if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
   require 'logger'
   RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end
