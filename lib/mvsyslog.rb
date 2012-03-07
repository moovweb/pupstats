#!/usr/bin/env ruby
 

module Mvsyslog
  require 'rubygems'
  require 'log4r'
  require 'log4r/outputter/syslogoutputter'
  include Log4r
  class Mvlog

    def initialize(process, name)
      @mylog = Log4r::Logger.new(process)
      @mylog.outputters = Log4r::SyslogOutputter.new(name, :facility => Syslog::LOG_LOCAL5, :ident => name)
      @mylog.debug "initialize logging for #{name}"
      @mylog
    end

    def loggit(msg, level="info")
      @mylog.send(level, msg)
    end

  end
end
