#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

@@CARBON_SERVER = '127.0.0.1'
@@CARBON_PORT = 2003
@@LISTEN_PORT = 2515

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
