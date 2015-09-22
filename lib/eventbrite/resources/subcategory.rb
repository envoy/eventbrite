module Eventbrite
  class Subcategory < APIResource
    def self.url
      "/subcategories"
    end

    def self.all(params={}, token=nil)
      response, token = Eventbrite.request(:get, url, token, params)
      Util.convert_to_eventbrite_object(response, token)
    end
  end
end
