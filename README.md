# Ruby Stream API

[![Gem Version](https://badge.fury.io/rb/ruby-stream-api.svg)](https://badge.fury.io/rb/ruby-stream-api)
[![Build Status](https://travis-ci.org/ruby-ee/ruby-stream-api.svg?branch=master)](https://travis-ci.org/ruby-ee/ruby-stream-api)
[![Test Coverage](https://img.shields.io/codecov/c/github/ruby-ee/ruby-stream-api.svg)](https://codecov.io/github/ruby-ee/ruby-stream-api?branch=master)

[![DevOps By Rultor.com](http://www.rultor.com/b/ruby-ee/ruby-stream-api)](http://www.rultor.com/p/ruby-ee/ruby-stream-api)
[![We recommend RubyMine](https://amihaiemil.com/images/rubymine-recommend.svg)](https://www.jetbrains.com/ruby/)

A Stream is a wrapper over a collection of elements offering a number of useful
operations to modify and/or get information about the collection. The operations are chainable and can be categorized as follows:

* **Source** operations -- these are the operations which are generating the Stream.
* **Intermediate** operations (skip, filter, map etc) -- operations which are altering the Stream and still leave it open for further modifications.
* **Terminal** operations (count, collect etc) -- operations which are executed after all the modifications have been done and are returning a finite result.

First glance: 

1) **Finite** Stream from an array:

```ruby
array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
stream = Stream::FromArray.new(array)
collected = stream
    .filter { |num| num % 2 == 0 }
    .skip(2)
    .collect
puts collected # [6, 8, 10]
```

2) Generate a (potentially) **infinite** stream:

```ruby
stream = Stream.generate(150) { &seed }
```

The ``generate`` method takes a ``limit`` (max number of elements) and a ``&seed`` Block function which
returns a new element at each ``seed.call``. A limit is necessary as, without it, this Stream would be infinite.
If no limit is specified, the default is ``100`` elements.

This mechanism is useful, for instance, when you have to consume an incomming stream of objects from some ``IO`` objects.

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'ruby-stream-api'
```

Or install it as a separate gem:
```bash
$gem install ruby-stream-api
```

To require it inside your Ruby program do:
```ruby
require 'stream'
```

## Not a Mixin

This is **not** a Mixin! The Stream is a proper object wrapping your collection(s). Furthermore, each object in this gem is immutable and therefore thread-safe -> the **intermediate** operations are not altering the instance on which they are called; instead, they create a new instance of the Stream with a modified version of the underlying collection.

## Contribute

If you would like to contribute, just open an Issue (bugs, feature requests, any improvement idea) or a PR.

In order to build the project, you need Bundler and Ruby >= 2.3.0.

Make sure the build passes:

```shell
$bundle install
$bundle exec rake
```
