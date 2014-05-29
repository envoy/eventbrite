module Eventbrite
  class User < APIResource
    def self.owned_events(user_id, params={})
      instance = self.new
      instance.refresh_from_url(self.owned_events_url(user_id), params)
      instance
    end

    private

    def self.owned_events_url(user_id)
      "/#{CGI.escape(class_name.downcase)}s/#{user_id}/owned_events"
    end
  end
end
