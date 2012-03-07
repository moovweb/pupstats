#!/usr/bin/env ruby

module Pupstats
  require File.join(File.dirname(__FILE__), '..', 'config', 'environment')
  require 'pupstats/server'
  require 'pupstats/transformer'
  require 'pupstats/sender'
end
