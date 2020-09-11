#require_relative "../lib/plant_advisor.rb"
#require 'pry'

# this file accepts everything we must require so we're not
# requiring everything on top of all other files!

require 'pry'
require 'colorize'
require 'httparty'

# .rb at the end of files are not required in ruby files
# one dot means "look for a folder in the current folder."
# two dots mean "look in a folder above the current folder"
require_relative '../lib/countries/api.rb'
require_relative '../lib/countries/cli.rb'
require_relative '../lib/countries/country.rb'