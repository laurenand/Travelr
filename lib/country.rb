class Country
    attr_accessor :name, :region, :population, :capital, :flag_link#, :borders, :languages
    @@all = []

    def initialize(hash)
        @name = hash[:name][0]
        @region = hash[:region]
        @population = hash[:population]
        @capital = hash[:capital]
        @flag_link = hash[:flag_link]
        # @borders = hash[:borders]
        # @languages = hash[:languages]
        self.class.all << self unless self.class.all.include?(self)
    end

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

    def self.clear_countries
        self.all.clear
    end
end

# add a find_or_create_by_name method so we don't send multiple requests
# for the same country