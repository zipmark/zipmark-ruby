[![Build Status](https://secure.travis-ci.org/zipmark/zipmark-ruby.png?branch=master)](https://travis-ci.org/zipmark/zipmark-ruby)
[![Dependency Status](https://gemnasium.com/zipmark/zipmark-ruby.png)](https://gemnasium.com/zipmark/zipmark-ruby)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/zipmark/zipmark-ruby)


# Zipmark Ruby Client

The Zipmark Ruby Client library is used to interact with Zipmark's [API](https://dev.zipmark.com).

## Installation

```sh
gem install zipmark
```
or in your Gemfile

```ruby
gem "zipmark"
```

### Instantiating a client

```ruby
require 'zipmark'

client = Zipmark::Client.new(
  :application_id => "app-id",
  :application_secret => "my-secret",
  :vendor_identifier => "vendor-ident"
)
```

Vendor Identifier, Application Identifier, Application Secret should be replaced with the
values provided by Zipmark.

### Production Mode

By default, Zipmark::Client sends all requests to our sandbox environment.  This environment is identical to production except money never actually is moved.  When you are putting your application into production and want people to actually be able to pay, you need to turn production mode on.

```ruby
client = Zipmark::Client.new(
  :application_id => "app-id",
  :application_secret => "my-secret",
  :vendor_identifier => "vendor-ident",
  :production => true
)
```

### Loading a Bill from a known Bill ID

```ruby
client.bills.find("bill-id")
```

Attempting to find a bill that doesn't exist will raise a Zipmark::NotFound error.

### Discovering available resources

Resources will contain an array of all available resources.

```ruby
client.resources.keys
```

### Creating a new Bill

Create a bill object, set required attributes, send it to Zipmark

```ruby
bill = client.bills.create(
  :identifier => "1234",
  :amount_cents => 100,
  :bill_template_id => bill_template_id,
  :memo => "My memo",
  :content => '{"memo":"My Memo"}',
  :customer_id => "Customer 1",
  :date => "20130805")
```

As an alternative, it is possible to build an object first and then save it afterwards

```ruby
bill = client.bills.build(
  :identifier => "1234",
  :amount_cents => 100,
  :bill_template_id => bill_template_id,
  :memo => "My memo",
  :content => '{"memo":"My Memo"}',
  :customer_id => "Customer 1",
  :date => "20130805")
bill.save
```

Regardless of which method is used, if a bill is valid, it was successfully saved to Zipmark:

```ruby
puts bill.errors unless bill.valid?
```

### Updating an existing Bill

Get the bill, make a change, send it back to Zipmark

### Retrieving a list of all Bills

Retrieve a list of all bills.

Get the number of objects available.

### Basic Iterator

The Zipmark_Iterator class understands Zipmark's pagination system.  It loads one page of objects at a time and will retrieve more objects as necessary while iterating through the objects.

Get the current object (returns null if the iterator has passed either end of the list)

Get the next/previous object (returns null if the next/previous object would pass either end of the list)

### Iterating through a list of all Bills

The Zipmark_Iterator can be used to iterate through all objects of a given resource type.

### Callback processing

The client is able to process, verify and extract data from callbacks received from the Zipmark service.

#### Setting up a Callback

Callbacks have to be enabled by creating a callback with an event type and the callback URL. To enable Zipmark to send a callback:

```ruby
callback = client.callbacks.create(
  :url => 'https://example.com/callback',
  :event => 'name_of_event')
```

The possible event names include:

 * bill.create
 * bill.update
 * bill_payment.create
 * bill_payment.update

#### Loading a callback response

#### Verifying a callback

To verify a callback, you need the entire request (headers, request body, etc.) so it has to be done from the context of the controller layer (or a model that is passed the entire request).

```ruby
# In a controller:
client.build_callback(request).valid?
```

Will return true or false, based on a signed header from Zipmark.

#### Retrieving the callback data

Valid callbacks contain events, object types and objects.  The below functions will return their respective values/objects, or null if the callback is invalid.

## API Documentation

Please see the [Zipmark API](https://dev.zipmark.com) or contact Zipmark Support via [email](mailto:developers@zipmark.com) or [chat](http://bit.ly/zipmarkAPIchat) for more information.

## Unit/Acceptance Tests

Tests are written in rspec.  To run the full test suite, execute the following:

```
bundle install

bundle exec rake spec
```
