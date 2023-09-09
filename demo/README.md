# Demo

A quickstart alchemy application. This is the starting point for creating a new Alchemy project.

## Structure

This app has a few endpoints that demonstrate Routing, Middleware, Authorization, and Controller basics.

`POST /signup`: Signup with a username and password.

`POST /login`: Use basic auth to log in, returning an access token.

`GET /user`: Get the currently logged in user, if authorized with token auth.

It also demonstrates some basics around Jobs, Scheduled Tasks, Database Access, Migrations, Seeding, and Testing.

Note: By default this uses an in memory SQLite database. As such, you'll need to run the migrations on your database each time, which you can do by passing the `migrate` argument when running your app; `swift run app --migrate`. To connect a real database, you can enter credentials in the `.env` file and update `App+Database.swift`.

## Documentation

For more, check out the Alchemy documentation at [alchemyswift.com](https://alchemyswift.com).
