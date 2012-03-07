module Pupstats
  module Transformer

    require 'eventmachine'
    require 'json'

    def process(options, logger)
      @@stats={"pupstats.total.compile" => [], "pupstats.total.run" => [], }
      receiver = Pupstats::Sender.new
      mydata = Array.new
      @@collection_timer = EM::PeriodicTimer.new(300) do
	mydata = []
	unless @@stats.length == 0
	j=Time.now.to_i
	  @@stats.each  do |k, v| 
	    if v.length > 0
	      mydata << "#{k}_avg #{v.inject(0.0) { |sum, el| sum + el } / v.size} #{j}"
	      mydata << "#{k}_min #{v.min} #{j}"
	      mydata << "#{k}_max #{v.max} #{j}"
	    else
	      mydata << "#{k}_avg 0 #{j}"
	      mydata << "#{k}_min 0 #{j}"
	      mydata << "#{k}_max 0 #{j}"
	    end
	  end
	end
	puts mydata
	receiver.send_data(mydata)
	puts "Flushed #{@@stats.length} items"
	logger.loggit("Flushed #{@@stats.length} items")
	@@stats={"pupstats.total.compile" => [], "pupstats.total.run" => []}
      end
    end

    module_function :process

    def receive_data(data)
      begin
	if data =~ /puppet-master\[\d{1,9}\]: Compiled catalog for \S+ in environment production in ([0-9\.]{2,12}) seconds/
	  @@stats["pupstats.total.compile"] << $1.to_f
	end
	if data =~ /puppet-agent\[\d{1,9}\]: Finished catalog run in ([0-9\.]{2,12}) seconds/
	  @@stats["pupstats.total.run"] << $1.to_f
	end
      rescue Exception => e
	puts "receive_data #{e.message}"
      end
    end

  end
end
