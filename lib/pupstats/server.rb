module Pupstats
  class Server
    require 'eventmachine'
    require 'pupstats/transformer'
    require 'mvsyslog'

    def daemonize(pid_file)
      # stolen prety completely from manhattan
      # google "double fork" and "daemonize" to get more data
      Process.setsid
      raise 'Second fork failed' if (pid = Process.fork()) == -1
      exit unless pid.nil?
      File.open(pid_file, 'w') do |f|
	f.write Process.pid.to_s
	#call the OS to sync the file system so we get this PID on disk ASAP
	`sync`
      end

      File.umask 0000
      STDIN.reopen '/dev/null'
      STDOUT.reopen '/dev/null', 'a'
      STDERR.reopen STDOUT
    end

    def split_server(pid_file)
      process = Process.fork do
	daemonize(pid_file)
	yield
      end
    end

    def run(options, logger)
      begin
	#set up the error handler here to catch any/all errors
	#if not done here you will waste hours trying to figure out what went wrong
	EM.error_handler do |e|
	  puts "Unsent Exception: #{e.to_s}\n#{e.backtrace.join("\n")}"
	end
	# real deal
	EventMachine::run do
	  begin
	    EventMachine::open_datagram_socket(options[:listen_ip], options[:port], Pupstats::Transformer)
	    logger.loggit("running on #{options[:port]}")
	    Pupstats::Transformer.process(options, logger)
	  rescue Exception => e
	    puts "EventMachineError: #{e.to_s}"
	  end
       end 
      rescue Exception => e
	puts "Run Error #{e.to_s}"
	exit!(1)
      end
    end

    def initialize(options)
      @logger = Mvsyslog::Mvlog.new("pupstats_change", "pupstats")
      options = { :listen_ip => "0.0.0.0",
		  :port => @@LISTEN_PORT,
		  :pid_file => "/tmp/pupstats.pid",
      }
      if options.has_key?:daemonize
	self.split_server(options[:pidfile]) do
	  self.run(options, @logger)
	end
      else
	self.run(options, @logger)
      end
    end

  end
end
