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

Pry.hooks = {before_session: ->(*args) { self.extend Rails::ConsoleMethods if defined?(Rails::ConsoleMethods) } }