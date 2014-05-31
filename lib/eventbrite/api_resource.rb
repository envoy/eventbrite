module Eventbrite
  class APIResource < EventbriteObject
    def self.class_name
      name_without_namespace = self.name.split('::')[-1]
      name_without_namespace.gsub(/([^\^])([A-Z])/,'\1_\2').downcase
    end

    def self.url
      if self == APIResource
        raise NotImplementedError.new('APIResource is an abstract class.  You should perform actions on its subclasses (Event, Attendee, etc.)')
      end
      "/#{CGI.escape(class_name.downcase)}s"
    end

    def url
      unless id = self.id
        raise InvalidRequestError.new("Could not determine which URL to request: #{self.class} instance has invalid ID: #{id.inspect}")
      end
      "#{self.class.url}/#{CGI.escape(id)}"
    end

    def refresh
      response, token = Eventbrite.request(:get, url, @token, @retrieve_options)
      refresh_from(response, token)
      self
    end

    def self.retrieve(id, token=nil)
      instance = self.new(id, token)
      instance.refresh
      instance
    end
  end
end
