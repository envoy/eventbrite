module Eventbrite
  class ContactList < APIResource
    def self.all(params={}, token=nil)
      unless user_id = params.delete(:user_id)
        raise InvalidRequestError.new('No user_id provided.')
      end

      response, token = Eventbrite.request(:get, self.all_url(user_id), token, params)
      Util.convert_to_eventbrite_object(response, token)
    end

    def self.retrieve(user_id, id, token=nil)
      instance = self.new(id, token)
      instance.user_id = user_id
      instance.refresh
      instance
    end

    def url
      "/users/#{CGI.escape(self.user_id)}#{self.class.url}/#{CGI.escape(self.id)}"
    end

    private

    def self.all_url(user_id)
      "/users/#{user_id}/#{CGI.escape(class_name.downcase)}s"
    end
  end
end
