[![Build Status](https://travis-ci.org/georgedrummond/github_analyze.svg?branch=master)](https://travis-ci.org/georgedrummond/github_analyze) [![Gem Version](https://badge.fury.io/rb/github_analyze.svg)](https://badge.fury.io/rb/github_analyze)

# GithubAnalyze

This gem reports the most or least popular languages used in a GitHub organization.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'github_analyze'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install github_analyze

## Usage

First [create a GitHub authentication token](https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line) 

```ruby
require 'github_analyze'

# Create an instance GithubAnalyze::Client
client = GithubAnalyze::Client.new(
  github_authentication_token: 'GITHUB_AUTHENTICATION_TOKEN'
)

# Look up an organization
organization = client.organization(name: 'github')

# Find out the most popular languages used in that organization
organization.most_common_languages # => ['Ruby', 'JavaScript', 'Go', 'C', 'Shell']

# Find least common languages used in that organization
organization.least_common_languages # => ['Ragel in Ruby Host', 'PowerShell', 'Scala', 'Clojure', 'Perl']
```

## Command Line

Run the `github_analyze help` command to see command line options

## Generate CSV export of repositories

```
gem install github_analyze
GITHUB_AUTHENTICATION_TOKEN=changeme github_analyze csv google /tmp/report.csv
cat /tmp/report.csv
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/georgedrummond/github_analyze. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Stackshare project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/georgedrummond/github_analyze/blob/master/CODE_OF_CONDUCT.md).
