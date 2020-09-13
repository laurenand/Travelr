class CLI
   
    def run 
        #starts application
        puts "Welcome!".black.on_blue
        puts "Looking for a country to travel to?".green
        puts "To get started enter a country's capital city!".blue
        puts "To exit, enter 'exit' at any time.".red
        CLI.get_country_by_capital_city
    end

    def self.get_country_by_capital_city
        #gathers list of countries that can be returned by calling the capital city
        capital_city = gets.chomp

        unless capital_city == 'exit'
            if API.valid_country?(capital_city.to_s)
                #binding.pry
                countries = API.get_country_by_capital_cities(capital_city)
                #the plurality is just because some capital city names actually belong to more than one country
                #countries.map { |country| country[:name] }
                puts ""
                puts "🌎 This capital city returns:".green
                Country.all.each_with_index do |country, index|
                    puts "   #{index += 1}. #{country}".green
                   #binding.pry 
                end
                
                self.get_country(capital_city)
            else
                puts ""
                puts "Your input does not belong to a country!".red
                puts "Please enter a valid capital city.".red
                self.get_country_by_capital_city
            end
        end
    end

    def self.get_country(capital_city)
        #
        countries_data = API.get_country_by_capital_cities(capital_city.to_s) # returns an array of nested country hashes

        puts ""
        puts "Please enter the number you would like to see.".blue
        
        input = gets.chomp

        unless input == 'exit'
            input = input.to_i
            if (1..countries_data.length).include?(input)
                new_country = Country.new(countries_data[input.to_i - 1])
                    # Country.new(countries_data[input.to_i - 1])
                    # passes argument into Country, creating a new instance
                    # this argument returns a hash of information from the countries_data array about the selected country
                puts ""
                puts ""
                puts "🌏 You chose #{new_country.name}!".blue
                puts "#{new_country.name} has a population of #{new_country.population}.".blue
                puts "It is located in the region of #{new_country.region}, and its capital is #{new_country.capital}.".blue
                puts "View a photo of #{new_country.name}'s country flag at 📷#{new_country.flag_link}.".blue
                puts ""
                
                self.view_my_collection
            else
                puts ""
                puts "Your entry is invalid!".red
                self.get_country(capital_city)
            end
        end
    end

    def self.view_my_collection
        puts "🌍 You have viewed the following countries:".green
        Country.countries_viewed.each {|country| puts "   -#{country}".blue}
        # binding.pry
    
        puts ""
        puts "To clear your countries, enter 'clear'.".green
        self.more_options
    end

    def self.more_options
        puts "To view another country, type 'view'.".green
        puts "To exit, type 'exit'.".red
        input = gets.chomp.downcase

        unless input == 'exit'
            input = input.downcase
            if input == 'view'
                puts ""
                puts "🌍 Enter a country's capital!".green
                self.get_country_by_capital_city
            elsif input == 'clear'
                Country.clear_countries
                puts ""
                puts "Your countries have been cleared.".green
                self.more_options
            else
                puts ""
                puts "Whoops! Please enter only from the prompts.".red
                puts ""
                puts "To clear your countries, enter 'clear'.".red
                self.more_options
            end
        end
    end
end