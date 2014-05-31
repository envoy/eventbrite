module Eventbrite
  class Team < APIArrayResource
    def self.retrieve(event_id, id, token=nil)
      instance = self.new(id, token)
      instance.event_id = event_id
      instance.refresh
      instance
    end

    def self.attendees(event_id, id, token=nil)
      response, token = Eventbrite.request(:get, self.attendees_url(event_id, id), token, params)
      Util.convert_to_eventbrite_object(response, token)
    end

    def url
      "/events/#{CGI.escape(self.event_id)}#{self.class.url}/#{CGI.escape(self.id)}"
    end

    private

    def self.attendees_url(event_id, id)
      "/events/#{CGI.escape(event_id)}#{url}/#{CGI.escape(id)}/attendees"
    end
  end
end
