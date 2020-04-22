require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require 'scrapper'

town_halls = Scrapper.new("http://annuaire-des-mairies.com/val-d-oise.html").perform

#binding.pry