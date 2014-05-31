require 'rest_client'
require 'hashie'

# Version
require 'eventbrite/version'

# Util
require 'eventbrite/util'

# Base
require 'eventbrite/eventbrite_object'
require 'eventbrite/api_resource'
require 'eventbrite/api_array_resource'

# Resources
require 'eventbrite/resources/event'
require 'eventbrite/resources/category'
require 'eventbrite/resources/user'
require 'eventbrite/resources/attendee'
require 'eventbrite/resources/order'
require 'eventbrite/resources/discount'
require 'eventbrite/resources/access_code'
require 'eventbrite/resources/transfer'
require 'eventbrite/resources/team'
require 'eventbrite/resources/contact_list'

# Errors
require 'eventbrite/errors/eventbrite_error'
require 'eventbrite/errors/api_error'
require 'eventbrite/errors/authentication_error'
require 'eventbrite/errors/invalid_request_error'

module Eventbrite
  @api_base = 'https://www.eventbriteapi.com'
  @api_version = 'v3'

  class << self
    attr_accessor :api_base, :api_version, :token
  end

  def self.api_url(url='')
    "#{@api_base}/#{api_version}#{url}"
  end

  def self.request(method, url, token, params={})
    unless token ||= @token
      raise AuthenticationError.new('No access token provided. Set your token using "Eventbrite.token = <access-token>"."')
    end

    url = api_url(url)

    case method.to_s.downcase.to_sym
    when :get
      # Make params into GET parameters
      url += "#{URI.parse(url).query ? '&' : '?'}#{uri_encode(params)}" if params && params.any?
      payload = nil
    else
      payload = uri_encode(params)
    end

    request_opts = {
      headers: request_headers(token),
      method: method,
      open_timeout: 30,
      payload: payload,
      url: url,
      timeout: 120
    }

    begin
      response = execute_request(request_opts)
    rescue RestClient::ExceptionWithResponse => e
      if rcode = e.http_code and rbody = e.http_body
        handle_api_error(rcode, rbody)
      else
        raise
      end
    end

    [parse(response), token]
  end

private

  def self.uri_encode(params)
    Util.flatten_params(params).map { |k,v| "#{k}=#{Util.url_encode(v)}" }.join('&')
  end

  def self.request_headers(token)
    headers = {
      user_agent: "Eventbrite RubyBindings/#{Eventbrite::VERSION}",
      authorization: "Bearer #{token}"
    }

    headers
  end

  def self.execute_request(opts)
    RestClient::Request.execute(opts)
  end

  def self.parse(response)
    begin
      # Would use :symbolize_names => true, but apparently there is
      # some library out there that makes symbolize_names not work.
      response = JSON.parse(response.body)
    rescue JSON::ParserError
      raise general_api_error(response.code, response.body)
    end

    Util.symbolize_names(response)
  end

  def self.general_api_error(rcode, rbody)
    APIError.new("Invalid response object from API: #{rbody.inspect} (HTTP response code was #{rcode})", rcode, rbody)
  end

  def self.handle_api_error(rcode, rbody)
    begin
      error = JSON.parse(rbody)
      error = Util.symbolize_names(error)
    rescue JSON::ParserError
      raise general_api_error(rcode, rbody)
    end

    case rcode
    when 400, 404
      # TODO: fix this
      raise InvalidRequestError.new(error[:error_description], rcode, rbody, error)
    when 401
      raise AuthenticationError.new(error[:error_description], rcode, rbody, error)
    else
      raise APIError.new(error[:error_description], rcode, rbody, error)
    end
  end
end
