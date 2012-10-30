# Zipmark Ruby Client

The Zipmark Ruby Client library is used to interact with Zipmark's [API](https://dev.zipmark.com).

## Installation

### Requirements

## Initialization

## Usage Examples

### Instantiating a client

Application Identifier and Application Secret should be replaced with the vendor application identifier and secret provided by Zipmark.

### Production Mode

### Loading a Bill from a known Bill ID


### Discovering available resources

Resources will contain an array of all available resources.

### Creating a new Bill

Create a bill object, set required attributes, send it to Zipmark

As an alternative, it is possible to build an object first and then save it afterwards


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

#### Loading a callback response

#### Verifying a callback

#### Retrieving the callback data

Valid callbacks contain events, object types and objects.  The below functions will return their respective values/objects, or null if the callback is invalid.

## API Documentation

Please see the [Zipmark API](https://dev.zipmark.com) or contact Zipmark Support via [email](mailto:developers@zipmark.com) or [chat](http://bit.ly/zipmarkAPIchat) for more information.

## Unit/Acceptance Tests
