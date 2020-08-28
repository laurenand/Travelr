class CLI2
    def self.run
        puts ""
        puts "Well, hello there! 👋"
        puts "You seem like someone who appreciates geography."
        puts "To get started, enter a country's calling code!"
        puts "If you're stuck, try '856,' the calling code for Laos! 🇱🇦"
        puts "To exit, enter 'exit' at any time."
        self.get_country_by_calling_code
    end
    
    def self.get_country_by_calling_code
        calling_code = gets.chomp

        unless calling_code == 'exit'
            if API.valid_country?(calling_code.to_i)
                countries = API.get_country_by_calling_code(calling_code)
                countries.map { |country| country[:name] }
                puts ""
                puts "🌎 This calling code returns:"
                Country.list_countries(countries).each_with_index do |country, index|
                    puts "   #{index += 1}. #{country}"
                end
                self.get_country(calling_code)
            else
                puts ""
                puts "Your input does not belong to a country!"
                puts "Please enter a valid calling code."
                self.get_country_by_calling_code
            end
        end
    end

    def self.get_country(calling_code)
        countries_data = API.get_country_by_calling_code(calling_code.to_i) # returns an array of nested country hashes

        puts ""
        puts "Please enter the number you would like to see."
        
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
                puts "🌏 You chose #{new_country.name}!"
                puts "#{new_country.name} has a population of #{new_country.population}."
                puts "It is located in the region of #{new_country.region}, and its capital is #{new_country.capital}."
                puts "View a photo of #{new_country.name}'s country flag at 📷#{new_country.flag_link}."
                puts ""
                
                self.view_my_collection
            else
                puts ""
                puts "Your entry is invalid!"
                self.get_country(calling_code)
            end
        end    
    end
        
    def self.view_my_collection
        puts "🌍 You have viewed the following countries:"
        Country.countries_viewed.each {|country| puts "   -#{country}"}
        # binding.pry
    
        puts ""
        puts "To clear your countries, enter 'clear'."
        self.more_options
    end

    def self.more_options
        puts "To view another country, type 'view'."
        puts "To exit, type 'exit'."
        input = gets.chomp.downcase

        unless input == 'exit'
            input = input.downcase
            if input == 'view'
                puts ""
                puts "🌍 Enter a country's calling code!"
                self.get_country_by_calling_code
            elsif input == 'clear'
                Country.clear_countries
                puts ""
                puts "Your countries have been cleared."
                self.more_options
            else
                puts ""
                puts "I did't quite catch that.."
                puts ""
                puts "To clear your countries, enter 'clear'."
                self.more_options
            end
        end
    end
end