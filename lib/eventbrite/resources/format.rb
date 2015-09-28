module Eventbrite
  class Format < APIResource
    def self.url
      # NOTE: even thought eb docs say '/format', it is '/formats'
      "/formats/"
    end

    def self.all(params={}, token=nil)
      response, token = Eventbrite.request(:get, url, token, params)
      Util.convert_to_eventbrite_object(response, token)
    end
  end
end
