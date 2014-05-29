module Eventbrite
  class Event < APIResource
    def self.search(search_term, params={})
      params.merge!(q: search_term)

      instance = self.new
      instance.refresh_from_url(self.search_url, params)
      instance
    end

    private

    def self.search_url
      url + '/search'
    end
  end
end
