# README

* Ruby version


* System dependencies

* Configuration

* Database 

If any DB issues happen try a fresh DB - `rake db:drop db:create db:migrate`.

* How to run the test suite

* Services 


* Deployment instructions

* ...

## Local Dev Notes

### Mail

Sending mail locally can have a few issues. To go around these, we will run a [local mail server](https://mailcatcher.me/) that will catch all outbound mail and give us a Web UI to view it.
To set this up, follow these directions:

1. gem install `mailcatcher`
2. Start mailcatcher: `mailcatcher`
3. Go to http://localhost:1080/
