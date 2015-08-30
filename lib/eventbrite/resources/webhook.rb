module Eventbrite
  class Webhook < APIArrayResource
    def self.create(body, token=nil)
      response, token = Eventbrite.request(:post, url, token, body)
      Util.convert_to_eventbrite_object(response, token)
    end

    def self.delete(id, token=nil)
      instance = self.new(id, token)
      response, token = Eventbrite.request(:delete, instance.url, token)
      Util.convert_to_eventbrite_object(response, token)
    end
  end
end
