module Eventbrite
  class User < APIResource
    ['orders', 'owned_events', 'owned_event_orders', 'owned_event_attendees', 'venues', 'organizers', 'organizations'].each do |m|
      define_singleton_method m do |params={}, token=nil|
        unless user_id = params.delete(:user_id)
          raise InvalidRequestError.new('No user_id provided.')
        end

        response, token = Eventbrite.request(:get, self.send("#{m}_url", user_id), token, params)
        Util.convert_to_eventbrite_object(response, token)
      end

      private

      define_singleton_method "#{m}_url" do |user_id|
        "/#{CGI.escape(class_name.downcase)}s/#{user_id}/#{m}"
      end
    end
  end
end
