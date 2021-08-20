# Server Quickstart

This is the starting point for an Alchemy server app. You can run it from Xcode or the CLI with `swift run`.

## Backend

This quickstart has simple endpoints around creating and authorizing users. It stores them in a database using the built in Rune ORM. It also has jumping off points for Migrations, Queues, Jobs, Scheduling, HTML and a few other common tasks.

The following endpoints are provided:

`GET /`: A simple `html` view that loads js & css.
`POST /login`: Logs a user in with an email and password.
`POST /signup`: Creates a new user.

Protected by token auth:

`GET /email`: Demonstrates token auth middleware and returns the user's email.

Note: you'll need to enter database credentials in the `.env` file or `App+Database.swift` to properly connect to your database. If you want to use the user endpoints, you'll also need to run the migrations on your database, which you can do by passing the `migrate` argument; `swift run Server migrate`.
