require 'rubygems'
require 'bundler'
Bundler.require :default

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'candle'
require 'utils'

DATA_PATH = File.join(File.dirname(__FILE__), 'data')
