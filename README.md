# Punctual

A journal app to remember tasks and set deadline for each.

## Features

- Create, read, update, delete category for task organization.
- Create, read, update, delete task in each category.
- User Authentication using devise.

## Entity Relationship Diagram

Below is the ERD of the application:

![ERD of the Application](https://drive.google.com/uc?export=view&id=1xB1kFGPvxB3hvrqYRwzofKEYX6edsIYa)

## Technologies

- Ruby 3.1.2
- Rails 6.1.6
- PostgreSQL 14.2
- NodeJS 16.15.0
- Yarn 1.22.18

## Getting started

To get started with the app, clone the repo and access the created directory:

```
$ git clone git@github.com:reyolan/punctual.git
$ cd punctual
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

Run the app by starting the Rails dev server and Vite.js dev server:

```
$ bin/rails server
$ bin/vite dev
```

You can then visit the site with this URL: http://localhost:3000

To receive e-mails, install mailcatcher gem:

```
$ gem install mailcatcher
$ mailcatcher
```

You can then visit http://127.0.0.1:1080/ to see the e-mails received.

## Test account

- Email: example@example.com
- Password: 1234567890
