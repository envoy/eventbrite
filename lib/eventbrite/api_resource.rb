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

    def refresh_from_url(url, params)
      response = Eventbrite.request(:get, url, params)
      refresh_from(response)
      self
    end

    def refresh
      response = Eventbrite.request(:get, url, @retrieve_options)
      refresh_from(response)
      self
    end

    def self.retrieve(id)
      instance = self.new(id)
      instance.refresh
      instance
    end
  end
end
