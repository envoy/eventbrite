# Eventbrite

[Eventbrite](http://developer.eventbrite.com/docs/) rubygem for API v3.

## Installation

Add this line to your application's Gemfile:

    gem 'eventbrite'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eventbrite

## Usage

### Access Token

Each method requires you have to a valid `access_token` that you obtain
via Eventbrite [OAuth 2.0](http://developer.eventbrite.com/docs/auth/) protocol.

There are two ways to use your `access_token` with this gem.

```ruby
# This token will be used globally each time you used the gem API.
Eventbrite.token = `your_access_token`
Eventbrite::Event.search({q: 'Dogecoin'})

# This is to specific the token you want to use for each API call.
Eventbrite::Event.search({q: 'Dogecoin'}, 'your_access_token')
```

### [Event Search](http://developer.eventbrite.com/docs/event-search/)

```ruby
# For supported parameters, check out the link above.
Eventbrite::Event.searh({q: 'Dogecoin'})
```

### [Event Categories](http://developer.eventbrite.com/docs/event-categories/)

```ruby
Eventbrite::Category.all
```

### [Event Details](http://developer.eventbrite.com/docs/event-details/)

```ruby
Eventbrite::Event.retrieve('event_id')
```

### [Event Attendees](http://developer.eventbrite.com/docs/event-attendees/)

```ruby
# For supported parameters, check out the link above.
# Also, the parameter `event_id` is required.
Eventbrite::Attendee.all({ event_id: '11669522857' })
```

### [Event Attendees’ Details](http://developer.eventbrite.com/docs/event-attendees-details/)

```ruby
Eventbrite::Attendee.retrieve('event_id', 'attendee_id')
```

### [Event Orders](http://developer.eventbrite.com/docs/event-orders/)

```ruby
# For supported parameters, check out the link above.
# Also, the parameter `event_id` is required.
Eventbrite::Order.all({ event_id: '11669522857' })
```

### [Order Details](http://developer.eventbrite.com/docs/order-details/)

```ruby
Eventbrite::Order.retrieve('order_id')
```

## Todo

* Event Atteedees' Details API should support parameters

## Thanks

* [Stripe Rubygem](https://github.com/stripe/stripe-ruby)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
