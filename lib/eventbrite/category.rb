module Eventbrite
  class Category < APIResource
    def self.url
      "/categories"
    end

    def self.all(params={})
      response = Eventbrite.request(:get, url, params)
      Util.convert_to_eventbrite_object(response)
    end
  end
end
