module Eventbrite
  class Category < APIResource
    def self.url
      "/categories"
    end

    def self.all(params={}, token=nil)
      response, token = Eventbrite.request(:get, url, token, params)
      Util.convert_to_eventbrite_object(response, token)
    end
  end
end
