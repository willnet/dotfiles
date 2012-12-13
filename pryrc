begin
  require 'hirb'
rescue LoadError
  # Missing goodies, bummer
end

if defined? Hirb
  # Dirty hack to support in-session Hirb.disable/enable
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      Pry.config.print = proc do |output, value|
        Hirb::View.view_or_page_output(value) || Pry::DEFAULT_PRINT.call(output, value)
      end
    end

    def disable_output_method
      Pry.config.print = proc { |output, value| Pry::DEFAULT_PRINT.call(output, value) }
      @output_method = nil
    end
  end

  Hirb.enable
end

def pbcopy(str)
  IO.popen('pbcopy', 'r+') {|io| io.puts str }
  puts "-- Copy to clipboard --\n#{str}"
end

Pry.config.commands.command "hiscopy", "History copy to clipboard" do |n|
  pbcopy _pry_.input_array[n ? n.to_i : -1]
end

Pry.config.commands.command "copy", "Copy to clipboard" do |str|
  unless str
    str = "#{_pry_.input_array[-1]}#=> #{_pry_.last_result}\n"
  end
  pbcopy str
end

Pry.config.commands.command "lastcopy", "Last result copy to clipboard" do
  pbcopy _pry_.last_result.chomp
end

if defined? PryNav
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
end

if defined? PryRails
  Pry.hooks.add_hook(:before_eval, :reload_everything) { reload!(true) }
end
