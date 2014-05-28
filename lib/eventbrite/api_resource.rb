module Eventbrite
  class APIResource < EventbriteObject
    def self.class_name
      self.name.split('::')[-1]
    end

    def self.url
      if self == APIResource
        raise NotImplementedError.new('APIResource is an abstract class.  You should perform actions on its subclasses (Event, Attendee, etc.)')
      end
      "/#{CGI.escape(class_name.downcase)}s"
    end

    def url
      unless id = self.id
        raise InvalidRequestError.new("Could not determine which URL to request: #{self.class} instance has invalid ID: #{id.inspect}", 'id')
      end
      "#{self.class.url}/#{CGI.escape(id)}"
    end

    def load(response)
      self.deep_merge!(response)
    end

    def self.retrieve(id)
      instance = self.new
      instance.id = id
      instance.load(Eventbrite.request(:get, instance.url))
      instance
    end
  end
end
