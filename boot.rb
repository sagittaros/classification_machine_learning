require 'rubygems'
require 'bundler'
Bundler.require :default

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'csv'
require 'svm'
require 'candle'
require 'classifier'
require 'utils'

DATA_PATH = File.join(File.dirname(__FILE__), 'data')
GRAPH_PATH = File.join(File.dirname(__FILE__), 'graphs')
