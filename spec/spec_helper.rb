require 'rubygems'
require 'bundler/setup'
require 'rspec'

project_root = File.absolute_path('lib')
Dir[project_root+"/**/*.rb"].each {|file| require file}
