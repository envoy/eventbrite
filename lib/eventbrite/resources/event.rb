module Eventbrite
  class Event < APIResource
    def self.search(params={}, token=nil)
      response, token = Eventbrite.request(:get, self.search_url, token, params)
      Util.convert_to_eventbrite_object(response, token)
    end

    private

    def self.search_url
      url + '/search'
    end
  end
end
