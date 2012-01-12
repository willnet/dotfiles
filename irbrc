require 'rubygems'
require 'irb/completion'
# require 'irbtools'
#require 'wirble'
#Wirble.init
#Wirble.colorize
# require 'hirb'
# Hirb.enable

IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:EVAL_HISTORY] = 30
IRB.conf[:AUTO_INDENT] = true

if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
   require 'logger'
   RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

=begin
if ENV.include?('RAILS_ENV')
   require "active_record"
   ActiveRecord::Base.logger = Logger.new(STDOUT)
end
=end
