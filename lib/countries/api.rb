require 'pry'

class API 
  
  #extracts data from API and determines if the country is valid
  def self.valid_country?(capital_city)
    url = "https://restcountries.eu/rest/v2/capital/#{capital_city}"
    response = HTTParty.get(url, follow_redirects: true) # sends request for data to url
    
    if response.ok?
        response
    end
  end

  #invokes valid country class method and iterates over hash of countries to assign value to each key
  def self.get_country_by_capital_cities(capital_city)
    response = self.valid_country?(capital_city)
    if response
      response.map do |data|
        #binding.pry
        hash = {}
        hash[:name] = data["name"],
        hash[:region] = data["region"],
        hash[:population] = data["population"],
        hash[:capital] = data["capital"],
        hash[:flag] = data["flag_link"]
        Country.new(hash)
      end
    end
  end
end