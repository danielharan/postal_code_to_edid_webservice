require 'mechanize'

module EdidSources
  class ElectionsCanada
    def self.edid_for(postal_code)
      postal_code.sub! ' ', '' # done in javascript on the site, "A1A1A1" is OK, "A1A 1A1" is NOT
      
      agent = Mechanize.new do |a|
        a.user_agent_alias = 'Mac Safari'
      end

      page = agent.get("http://www.elections.ca/home.asp")
      page.parser.encoding = 'utf8'
      search_results =  page.form_with(:name => "POSTAL") do |lookup|
        lookup.field_with(:name => "PC").value = postal_code
      end.submit

      search_results.uri.to_s.match(/&ED=(\d+)&/)[1]
    end
  end
end