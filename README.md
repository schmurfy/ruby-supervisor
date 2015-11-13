
[![Build Status](https://secure.travis-ci.org/schmurfy/ruby-supervisor.png)](https://secure.travis-ci.org/schmurfy/ruby-supervisor.png)

# What is this ?

I needed an interface to Supervisor, a python alternative to daemontools amongst others and
since I did not found any in ruby I made mine !

Instead of blindly mapping the XML-RPC methods I decided to built an API which feels more
like a native ruby API than an ugly java like thing.

# Getting started

Add to your Gemfile

```ruby
gem 'ruby-supervisor'
```

And then execute

`
$ bundle install
`

Or install the gem yourself

`
$ gem install ruby-supervisor
`

# Examples

```ruby
require 'ruby-supervisor'
client = RubySupervisor::Client.new('192.168.0.32', 9001,
    :user => 'user',
    :password => 'secret'
  )

process = client.process('collectd')

puts "You are running supervisor version #{client.version}"

p process.state
# => :running

p process.logs.read(0, 21)
# => "some line of 21 bytes"

process.logs.clear
process.restart
```



# Development

- clone the repository
- run "bundle"
- run "bundle exec guard" to automatically run tests on changes
- run "bundle exec rake rspec" to run all specs

# Supported versions

- ruby 1.9.2
- ruby 1.8.7
