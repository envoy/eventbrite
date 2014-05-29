module Eventbrite
  class Attendee < APIResource
    def self.retrieve(event_id, id)
      instance = self.new(id)
      instance.event_id = event_id
      instance.refresh
      instance
    end

    def self.all(event_id, params={})
      instance = self.new
      instance.refresh_from_url(self.all_url(event_id), params)
      instance
    end

    def url
      "/events/#{CGI.escape(self.event_id)}#{self.class.url}/#{CGI.escape(self.id)}"
    end

    private

    def self.all_url(event_id)
      "/events/#{event_id}/#{CGI.escape(class_name.downcase)}s"
    end
  end
end
