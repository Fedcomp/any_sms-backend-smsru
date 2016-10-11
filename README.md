# ActiveSMS sms.ru backend

[![Build Status](https://travis-ci.org/Fedcomp/active_sms-backend-smsru.svg?branch=master)](https://travis-ci.org/Fedcomp/active_sms-backend-smsru)
[![Gem Version](https://badge.fury.io/rb/active_sms-backend-smsru.svg)](https://badge.fury.io/rb/active_sms-backend-smsru)

backend for [ActiveSMS](https://github.com/Fedcomp/active_sms) to work with [sms.ru](https://sms.ru)

## Installation and usage

Add this line to your application's Gemfile:

```ruby
gem "active_sms"
gem "active_sms-backend-smsru"
```

Then somewhere in your initialization code:

```ruby
require "active_sms"

ActiveSMS.configure do |c|
  c.register_backend :my_main_backend,
                     ActiveSMS::Backend::Smsru,
                     api_id: ENV["SMSRU_TOKEN"]

  c.default_backend = :my_main_backend
end
```

Now, whenever you need to send SMS, just do:

```ruby
phone = "799999999"
text = "My sms text"

# Should actually send sms
ActiveSMS.send_sms("79999999999", "text")
```

For more advanced usage please
go to [ActiveSMS documentation](https://github.com/Fedcomp/active_sms#real-life-example)

**Don't forget**, you need to put real *api_id* in SMSRU_TOKEN environment variable.
In bash you would do it like that:
```bash
export SMSRU_TOKEN "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
```
Read below how to receive own token to work with sms.ru.

# Receiving api_id from sms.ru

First of all, you should register on https://sms.ru/ .
Then, when you are registered, make sure you have
some small amount of balance to actually send sms.
On your main page (when you are logged)
you should see:

![api_id block at the right](screenshot.png)

instead of XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX you should see your actual api_id key.

## Contributing

Bug reports and pull requests are
welcome on GitHub at https://github.com/Fedcomp/active_sms-backend-smsru

## Submitting a Pull Request
1. Fork the [official repository](https://github.com/Fedcomp/active_sms-backend-smsru).
2. Create a topic branch.
3. Implement your feature or bug fix.
4. Add, commit, and push your changes.
5. Submit a pull request.

* Please add tests if you changed code. Contributions without tests won't be accepted.
* If you don't know how to add tests, please put in a PR and leave a comment
  asking for help.
* Please don't update the Gem version.

( Inspired by https://github.com/thoughtbot/factory_girl/blob/master/CONTRIBUTING.md )

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
