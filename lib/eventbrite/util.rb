module Eventbrite
  module Util
    def self.object_classes
      @object_classes ||= {
        events: Event,
        categories: Category,
        attendees: Attendee,
        orders: Order,
        discouns: Discount,
        access_codes: AccessCode,
        ticket_classes: TicketClass,
        transfers: Transfer,
        teams: Team,
        webhooks: Webhook
        # 'balance' => Balance,
        # 'balance_transaction' => BalanceTransaction,
        # 'charge' => Charge,
        # 'customer' => Customer,
        # 'invoiceitem' => InvoiceItem,
        # 'invoice' => Invoice,
        # 'plan' => Plan,
        # 'coupon' => Coupon,
        # 'event' => Event,
        # 'transfer' => Transfer,
        # 'recipient' => Recipient,
        # 'card' => Card,
        # 'subscription' => Subscription,
        # 'list' => ListObject,
        # 'application_fee' => ApplicationFee
      }
    end

    def self.convert_to_eventbrite_object(resp, token, parent=nil)
      # TODO: fix this
      case resp
      when Array
        resp.map { |i| convert_to_eventbrite_object(i, token, parent) }
      when Hash
        # Try converting to a known object class.  If none available, fall back to generic EventbriteObject
        object_classes.fetch(parent, EventbriteObject).construct_from(resp, token)
      else
        resp
      end
    end

    def self.symbolize_names(object)
      case object
      when Hash
        new = {}
        object.each do |key, value|
          key = (key.to_sym rescue key) || key
          new[key] = symbolize_names(value)
        end
        new
      when Array
        object.map { |value| symbolize_names(value) }
      else
        object
      end
    end

    def self.url_encode(key)
      parser = URI.const_defined?(:Parser) ? URI::Parser.new : URI
      parser.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    end

    def self.flatten_params(params, parent_key=nil)
      result = []
      params.each do |key, value|
        calculated_key = parent_key ? "#{parent_key}[#{url_encode(key)}]" : url_encode(key)
        if value.is_a?(Hash)
          result += flatten_params(value, calculated_key)
        elsif value.is_a?(Array)
          result += flatten_params_array(value, calculated_key)
        else
          result << [calculated_key, value]
        end
      end
      result
    end

    def self.flatten_params_array(value, calculated_key)
      result = []
      value.each do |elem|
        if elem.is_a?(Hash)
          result += flatten_params(elem, calculated_key)
        elsif elem.is_a?(Array)
          result += flatten_params_array(elem, calculated_key)
        else
          result << ["#{calculated_key}[]", elem]
        end
      end
      result
    end
  end
end
