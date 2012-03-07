#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), '..', 'config', 'environment')
require 'pupstats'

options = {}

begin
  pupstats_serv=Pupstats::Server.new(options)
rescue Exception => e
  puts "Error main: #{e.inspect}"
end
