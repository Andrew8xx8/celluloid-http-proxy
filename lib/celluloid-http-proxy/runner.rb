class Celluloid::Http::Proxy::Runner

  class OptionsParser
    def parse!(args)
      options = {}

      opt_parser = OptionParser.new do |opts|

        opts.on("-E", "--environment ENVIRONMENT", "Environment") do |environment|
          options[:environment] = environment
        end

        opts.on("-D", "--daemonize", "Run daemonized") do |f|
          options[:daemonize] = f
        end

        opts.on("-P", "--pid FILE", "File to store PID") do |file|
          options[:pidfile] = ::File.expand_path(file)
        end

        opts.on("-p", "--port PORT", "Port for bind") do |port|
          options[:port] = port.to_i
        end

        opts.on("-o", "--host HOST", "bind to HOST") do |host|
          options[:host] = host
        end

      end

      begin
        opt_parser.parse! args
      rescue OptionParser::InvalidOption => e
        warn e.message
        abort opt_parser.to_s
      end

      options
    end
  end

  def default_options
    {
      :environment => ENV['RACK_ENV'] || "development",
      :port        => 9292,
      :host     => "127.0.0.1"
    }
  end

  def run(args, handlers_provider = nil)
    options = default_options.dup

    parser = OptionsParser.new
    options.update parser.parse!(args)

    Process.daemon if options[:daemonize]
    write_pidfile(options[:pidfile]) if options[:pidfile]

    Reel::Server.run(options[:host], options[:port]) do |connection|
      Celluloid::Http::Proxy::Connection.new(handlers_provider).accept(connection)
    end
  end

  def write_pidfile(pidfile)
    @simple_pid = SimplePid.new(pidfile)

    if @simple_pid.exists?
      unless @simple_pid.running?
        @simple_pid.cleanup
        @simple_pid.write!
      end
    else
      @simple_pid.write!
    end

  end

  def self.run(args)
    new.run(args)
  end

end
