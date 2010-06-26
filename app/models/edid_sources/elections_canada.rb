require 'net/http'
require 'uri'

module EdidSources
  class ElectionsCanada
    def self.edids_for(postal_code)
      postal_code.sub! ' ', '' # done in javascript on the site, "A1A1A1" is OK, "A1A 1A1" is NOT

      response = scrape(postal_code)
      
      if response["Location"]
        [response["Location"].match(/&ED=(\d+)&/)[1]]
      elsif response.body =~ /Your postal code information did not identify a valid electoral district/i
       [nil]
      elsif response.body =~ /Your postal code identified more than one electoral district/i
        []
      else
        raise "error scraping page for postal code: #{postal_code}"
      end
    end
    
    def self.scrape(postal_code)
      Net::HTTP.get_response(URI.parse("http://www.elections.ca/scripts/pss/FindED.aspx?PC=#{postal_code}&image.x=0&image.y=0"))
    end
  end
end