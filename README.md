# Punctual

An app to remember tasks and set deadline for each.

## Features

- Create, read, update, delete category for task organization.
- Create, read, update, delete task in each category.
- User Authentication using devise.

## Getting started

To get started with the app, clone the repo and access the created directory:

```
$ git clone git@github.com:reyolan/punctual.git
$ cd punctual
```

Make sure you're using a compatible version of Node.js:

```
$ node -v
v16.15.0
```

Install the needed gems and node modules:

```
$ bundle install
$ yarn
```

Next, create and setup the database (database migrations/schema):

```
$ bin/rails db:setup
```

Finally, run the test suite to verify that all features work correctly:

```
$ bin/rails test
```

Run the app in a local server:

```
$ bin/rails server
```

You can then visit the site with this URL: http://localhost:3000

To receive e-mails, install mailcatcher gem:

```
$ gem install mailcatcher
$ mailcatcher
```

You can then visit http://127.0.0.1:1080/ to receive e-mails.
