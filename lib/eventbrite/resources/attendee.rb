module Eventbrite
  class Attendee < APIArrayResource
    def self.retrieve(event_id, id, token=nil)
      instance = self.new(id, token)
      instance.event_id = event_id
      instance.refresh
      instance
    end

    def url
      "/events/#{CGI.escape(self.event_id)}#{self.class.url}/#{CGI.escape(self.id)}"
    end
  end
end
