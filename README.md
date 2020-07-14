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

### Pagination

Please not that not all APIs have pagination.

```ruby
events = Eventbrite::Event.search({q: 'Dogecoin'})
events.paginated? # => true

# Get all events
all_events = events.events
while events.next?
  events = Eventbrite::Event.search({q: 'Dogecoin', page: events.next_page})
  all_events.concat(events.events)
end
```

### [Event Search](http://developer.eventbrite.com/docs/event-search/)

```ruby
# For supported parameters, check out the link above.
Eventbrite::Event.search({q: 'Dogecoin'})
```

### [Event Categories](http://developer.eventbrite.com/docs/event-categories/)

```ruby
Eventbrite::Category.all
```

### [Event Subcategories](https://www.eventbrite.com/developer/v3/endpoints/categories/#ebapi-get-subcategories/)

```ruby
Eventbrite::Subcategory.all
```

### [Event Formats](https://www.eventbrite.com/developer/v3/endpoints/formats/)

```ruby
Eventbrite::Format.all
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

### [Event Ticket Classes](https://www.eventbrite.com/developer/v3/endpoints/events/#ebapi-get-events-id-ticket-classes)

```ruby
# The parameter `event_id` is required.
Eventbrite::TicketClass.all({ event_id: 'event_id' })
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

### [User Orders (DEPRECATED)](https://www.eventbrite.com/platform/docs/changelog)

```ruby
# The parameter `user_id` is required.
Eventbrite::User.orders({ user_id: 'user_id' })
```

### [User Owned Events (DEPRECATED)](https://www.eventbrite.com/platform/docs/changelog)

```ruby
# For supported parameters, check out the link above.
# Also, the parameter `user_id` is required.
Eventbrite::User.owned_events({ user_id: 'user_id' })
```

### [User Owned Events’ Orders (DEPRECATED)](https://www.eventbrite.com/platform/docs/changelog)

```ruby
# For supported parameters, check out the link above.
# Also, the parameter `user_id` is required.
Eventbrite::User.owned_event_orders({ user_id: 'user_id' })
```

### [User Owned Event’s Attendees (DEPRECATED)](https://www.eventbrite.com/platform/docs/changelog)

```ruby
# For supported parameters, check out the link above.
# Also, the parameter `user_id` is required.
Eventbrite::User.owned_event_attendees({ user_id: 'user_id' })
```

### [User Venues (DEPRECATED)](https://www.eventbrite.com/platform/docs/changelog)

```ruby
# Retrieve a User’s Venues
# The parameter `user_id` is required.
Eventbrite::User.venues({ user_id: 'user_id' })
# Retrieve a Venue
Eventbrite::Venue.retrieve('venue_id')
```

### [User Organizers (DEPRECATED)](https://www.eventbrite.com/platform/docs/changelog)

```ruby
# The parameter `user_id` is required.
Eventbrite::User.organizers({ user_id: 'user_id' })
```

 ### [User Organizations](https://www.eventbrite.com/platform/api#/reference/organization/list-your-organizations/list-your-organizations)

```ruby
# Retrieve an User’s Organizations
# You will need the users organization ID to retrieve resources from the organization endpoints.
# You can use 'me' as a user_id to retrieve your organizations.
Eventbrite::User.organizations({ user_id: 'user_id' })
```

### [Organization Events](https://www.eventbrite.com/platform/api#/reference/event/update/list-events-by-organization)

```ruby
# Retrieve an Organization’s Events
# For supported parameters, check out the link above.
# Also, the parameter `organization_id` is required.
Eventbrite::Organization.events({ organization_id: 'organization_id' })
```

### [Organization Orders](https://www.eventbrite.com/platform/api#/reference/order/retrieve/list-orders-by-organization-id)

```ruby
# Retrieve an Organization’s Orders
# For supported parameters, check out the link above.
# Also, the parameter `organization_id` is required.
Eventbrite::Organization.orders({ organization_id: 'organization_id' })
```

### [Organization Attendees](https://www.eventbrite.com/platform/api#/reference/attendee/list-attendees-by-organization)

```ruby
# Retrieve an Organization’s Attendees
# For supported parameters, check out the link above.
# Also, the parameter `organization_id` is required.
Eventbrite::Organization.attendees({ organization_id: 'organization_id' })
```

### [Organization Venues](https://www.eventbrite.com/platform/api#/reference/venue/list/list-venues-by-organization)

```ruby
# Retrieve an Organization’s Venues
# The parameter `organization_id` is required.
Eventbrite::Organization.venues({ organization_id: 'organization_id' })
# Retrieve a Venue
Eventbrite::Venue.retrieve('venue_id')
```

### [Organization Webhooks](https://www.eventbrite.com/platform/api#/reference/webhooks/list/list-webhook-by-organization-id)

```ruby
# Retrieve an Organization’s Webhooks
# The parameter `organization_id` is required.
Eventbrite::Organization.webhooks({ organization_id: 'organization_id' })
```

### [Organization Organizers](https://www.eventbrite.com/platform/docs/changelog)

```ruby
# Retrieve an Organization’s Organizers
# The parameter `organization_id` is required.
Eventbrite::Organization.organizers({ organization_id: 'organization_id' })
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

### [Webhooks](http://www.eventbrite.com/developer/v3/endpoints/webhooks/)

```ruby
# Retrieve a Webhook.
Eventbrite::Webhook.retrieve('webhook_id')

# Create a Webhook.
# See above link for supported parameters.
Eventbrite::Webhook.create({endpoint_url: 'your_webhooks_endpoint_url'})

# Delete a Webhook.
Eventbrite::Webhook.delete('webhook_id')

```
### [Expansions](https://www.eventbrite.com/developer/v3/api_overview/expansions/)

```ruby
# For supported expansions, check out the link above.
# Required parameters dependent on method called, refer to methods covered above for required parameters

# Retrieve venue information with events
Eventbrite::User.owned_events({ user_id: 'user_id', expand: 'venue' })

# Retrieve organizer and venue information with events
Eventbrite::User.owned_events({ user_id: 'user_id', expand: 'organizer,venue' })
```


## Todo

* Event Attendees' Details API should support parameters
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

