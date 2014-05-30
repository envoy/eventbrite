module Eventbrite
  class User < APIResource
    def self.owned_events(params={}, token=nil)
      unless user_id = params.delete(:user_id)
        raise InvalidRequestError.new('No user_id provided.')
      end

      response, token = Eventbrite.request(:get, self.owned_events_url(user_id), token, params)
      Util.convert_to_eventbrite_object(response, token)
    end

    private

    def self.owned_events_url(user_id)
      "/#{CGI.escape(class_name.downcase)}s/#{user_id}/owned_events"
    end
  end
end
