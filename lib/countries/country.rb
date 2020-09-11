require 'pry'

class Country
    attr_accessor :name, :region, :population, :capital, :flag_link
    #sets and gets instance variables
    @@all = []

    #what is called on with each new run
    def initialize(hash)
        @name = hash[:name][0]
        @region = hash[:region]
        @population = hash[:population]
        @capital = hash[:capital]
        @flag_link = hash[:flag_link]
        self.class.all << self unless self.class.all.include?(self)
    end

    #holds class variable which stores all country data
    def self.all
        @@all
    end

    # this method views all country instances created..
    def self.countries_viewed
        self.all.map { |country| country.name }
    end

    # while this method lists all results of the API search
    def self.list_countries(countries_hash)
        countries_hash.map do |country|
            country[:name][0]
        end
    end

    #will find a valid country if one does not already exist and will create one if that country does not exist
    def self.find_or_create_by_name(name)
        countries = self.all.find {|country| country.name == name}
        if countries.nil?
          country
        else
          self.new(name)
        end
    end

    #clears data 
    def self.clear_countries
        self.all.clear
    end
end