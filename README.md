# Eventbrite

[Eventbrite](http://developer.eventbrite.com/docs/) rubygem for API v3.

## Installation

NOTE: PLEASE NOTE THAT WE ARE STILL TRYING TO ACQUIRE THE GEM NAME `eventbrite`.

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

### Pagination

Please not that not all APIs have pagination.

```ruby
events = Eventbrite::Event.searh({q: 'Dogecoin'})
events.paginated? # => true

# Get all events
all_events = events.events
while events.next?
  events = Eventbrite::Event.searh({q: 'Dogecoin', page: events.next_page})
  all_events.concat(events.events)
end
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
Eventbrite::Attendee.all({ event_id: 'event_id' })
```

### [Event Attendees’ Details](http://developer.eventbrite.com/docs/event-attendees-details/)

```ruby
Eventbrite::Attendee.retrieve('event_id', 'attendee_id')
```

### [Event Orders](http://developer.eventbrite.com/docs/event-orders/)

```ruby
# For supported parameters, check out the link above.
# Also, the parameter `event_id` is required.
Eventbrite::Order.all({ event_id: 'event_id' })
```

### [Event Discounts](http://developer.eventbrite.com/docs/event-discounts/)

```ruby
# For supported parameters, check out the link above.
# Also, the parameter `event_id` is required.
Eventbrite::Discount.all({ event_id: 'event_id' })
```

### [Event Access Codes](http://developer.eventbrite.com/doc/event-access-codes/)

```ruby
# For supported parameters, check out the link above.
# Also, the parameter `event_id` is required.
Eventbrite::AccessCode.all({ event_id: 'event_id' })
```

### [Event Transfers](http://developer.eventbrite.com/docs/event-transfers/)

```ruby
# The parameter `event_id` is required.
Eventbrite::Transfer.all({ event_id: 'event_id' })
```

### [Event Teams](http://developer.eventbrite.com/docs/event-teams/)

```ruby
# The parameter `event_id` is required.
Eventbrite::Team.all({ event_id: 'event_id' })
```

### [Event Teams Details](http://developer.eventbrite.com/docs/event-teams-details/)

```ruby
Eventbrite::Team.retrieve('event_id', 'team_id')
```

### [Event Teams’ Attendees](http://developer.eventbrite.com/docs/event-teams-attendees/)

```ruby
Eventbrite::Team.attendees('event_id', 'team_id')
```

### [User Details](http://developer.eventbrite.com/docs/user-details/)

```ruby
Eventbrite::User.retrieve('user_id')
```

### [User Orders](http://developer.eventbrite.com/docs/user-orders/)

```ruby
# The parameter `user_id` is required.
Eventbrite::User.orders({ user_id: 'user_id' })
```

### [User Owned Events](http://developer.eventbrite.com/docs/user-owned-events/)

```ruby
# For supported parameters, check out the link above.
# Also, the parameter `user_id` is required.
Eventbrite::User.owned_events({ user_id: 'user_id' })
```

### [User Owned Events’ Orders](http://developer.eventbrite.com/docs/user-owned-events-orders/)

```ruby
# For supported parameters, check out the link above.
# Also, the parameter `user_id` is required.
Eventbrite::User.owned_event_orders({ user_id: 'user_id' })
```

### [User Owned Event’s Attendees](http://developer.eventbrite.com/docs/user-owned-events-attendees/)

```ruby
# For supported parameters, check out the link above.
# Also, the parameter `user_id` is required.
Eventbrite::User.owned_event_attendees({ user_id: 'user_id' })
```

### [User Venues](http://developer.eventbrite.com/docs/user-venues/)

```ruby
# The parameter `user_id` is required.
Eventbrite::User.venues({ user_id: 'user_id' })
```

### [User Organizers](http://developer.eventbrite.com/docs/user-organizers/)

```ruby
# The parameter `user_id` is required.
Eventbrite::User.organizers({ user_id: 'user_id' })
```

### [Order Details](http://developer.eventbrite.com/docs/order-details/)

```ruby
Eventbrite::Order.retrieve('order_id')
```

### [Contact Lists](http://developer.eventbrite.com/docs/contact-lists/)

```ruby
# For supported parameters, check out the link above.
# Also, the parameter `user_id` is required.
Eventbrite::ContactList.all({ user_id: 'user_id' })
```

### [Contact List Details](http://developer.eventbrite.com/docs/contact-list-details/)

```ruby
Eventbrite::ContactList.retrieve('user_id', 'contact_list_id')
```

## Todo

* Event Atteedees' Details API should support parameters
* POST/UPDATE/DELETE request for the API
* Support for chained method

## Thanks

* [Stripe Rubygem](https://github.com/stripe/stripe-ruby)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
