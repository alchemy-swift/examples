# Fullstack Quickstart

This is the starting point for a fullstack swift iOS app. It's a monorepo that contains an iOS target, Alchemy server & Shared library for sharing code. You can run `iOS` and `Server` from Xcode or the `Server` from the CLI with `swift run`.

## iOS

A simple SwiftUI app with an AuthView & HomeView that let a user login / sign and create a list of todos.

## Backend

A server that provides the endpoints in Shared and stores Users and Todos to a database. Demonstrates using the built in Rune ORM to work with databases.

Note: you'll need to enter database credentials in the `.env` file or `App+Database.swift` to properly connect to your database. You'll also need to run the migrations on your database, which you can do by passing the `migrate` argument; `swift run Server migrate`.

## Shared

API interfaces are defined in `AuthAPI.swift` and `TodoAPI.swift`. Typesafe endpoints make it easy to spin up new endpoints with Alchemy and consume them on iOS or macOS.

The following endpoints are provided:

`POST /login`: Logs a user in with an email and password.
`POST /signup`: Creates a new user.

Protected by token auth:

`GET /todo`: Lists all the todos of the user.
`POST /todo`: Creates a new todo.
`PUT /todos/:id` : Edits todo with id.
`DELETE /todos/:id` : Deletes todo with id.
