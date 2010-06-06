require 'mechanize'

module EdidSources
  class ElectionsCanada
    def self.edid_for(postal_code)
      postal_code.sub! ' ', '' # done in javascript on the site, "A1A1A1" is OK, "A1A 1A1" is NOT

      search_results = scrape(postal_code)
      
      if match = search_results.uri.to_s.match(/&ED=(\d+)&/)
        [match[1]]
      elsif search_results.content =~ /Your postal code information did not identify a valid electoral district/i
        []
      elsif search_results.content =~ /Your postal code identified more than one electoral district/i
        ["multiple", search_results.uri]
      else
        raise "error scraping page for postal code: #{postal_code}"
      end
    end
    
    def self.scrape(postal_code)
      agent = Mechanize.new do |a|
        a.user_agent_alias = 'Mac Safari'
      end

      page = agent.get("http://www.elections.ca/home.asp")
      page.parser.encoding = 'utf8'
      page.form_with(:name => "POSTAL") do |lookup|
        lookup.field_with(:name => "PC").value = postal_code
      end.submit
    end
  end
end