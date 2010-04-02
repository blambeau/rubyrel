#!/usr/bin/env rackup
require "rubygems"
gem 'waw', '>= 0.2.2'
require "waw"
run Waw.autoload(__FILE__)
