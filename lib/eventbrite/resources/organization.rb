module Eventbrite
  class Organization < APIResource
    ['attendees', 'events', 'orders', 'organizers', 'venues', 'webhooks'].each do |m|
      define_singleton_method m do |params={}, token=nil|
        unless organization_id = params.delete(:organization_id)
          raise InvalidRequestError.new('No organization_id provided.')
        end

        response, token = Eventbrite.request(:get, self.send("#{m}_url", organization_id), token, params)
        Util.convert_to_eventbrite_object(response, token)
      end

      private

      define_singleton_method "#{m}_url" do |organization_id|
        "/#{CGI.escape(class_name.downcase)}s/#{organization_id}/#{m}"
      end
    end
  end
end
