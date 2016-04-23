# Easy Exchange Rates

[![Build Status](https://travis-ci.org/info-sig/easy-exchange-rates.png?branch=master)](https://travis-ci.org/info-sig/easy-exchange-rates) [![Code Climate](https://codeclimate.com/github/info-sig/easy-exchange-rates.png)](https://codeclimate.com/github/bbozo/simple_form_class)

A simple, light-weight API service for exchange rates.

## APIs

So far we only have the Croatia National Bank API (HNB, Hrvatska Narodna Banka), but ideally this should extended to a few others as well.

The application is deployed on heroku on http://easy-exchange-rates.herokuapp.com (the URL will redirect to this page). All API's are simple GET requests, but the code should responde to other verbs as well. API endpoints are the following:

1. HNB original file: [/hnb/original](http://easy-exchange-rates.herokuapp.com/hnb/original)
2. HNB JSON: [/hnb/json](http://easy-exchange-rates.herokuapp.com/hnb/json)
3. HNB XML: [/hnb/xml](http://easy-exchange-rates.herokuapp.com/hnb/xml)

## Architecture

A simple [Roda](https://github.com/jeremyevans/roda) application running on [Puma](https://github.com/puma/puma) on Heroku with no infrastructure attached to it, just a simple in-memory store for cacheing.


## License

The app is provided freely under the [MIT license](https://github.com/info-sig/easy-exchange-rates/blob/master/MIT-LICENSE)


## Author

Borna Novak (bonovak@gmail.com)
