# DummyJSON Products

A Flutter app that uses the [DummyJSON API](https://dummyjson.com/) to sign in and browse products.

## Getting started

Flutter version 3.47.1, Dart 3.13.1 then run:

```sh
flutter pub get
flutter run
```

Sign in with the test account: `emilys` / `emilyspass`.

## Features

- Sign in, restore a session and sign out.
- Browse products with pagination and pull to refresh.
- View loading, error and empty states, and open product details.
- Switch between light and dark themes.

## Architecture

The app uses feature-first folders and follows **UI → Cubit → Controller → Service**:

- Widgets display state and call Cubit methods. Cubit manages the UI state.
- Controllers handle feature logic, such as pagination and session restoration.
- Services handle API and storage operations. A shared `Result` carries success or failure back to the caller.

I chose Cubit for straightforward state management, GoRouter for navigation and auth redirects, and GetIt to wire dependencies in one place. HTTP requests use the `http` package through a shared API service.

## Authentication

Access and refresh tokens are stored using `flutter_secure_storage`. On startup, the app verifies the saved session by fetching the user's profile. If the access token is rejected, it attempts to refresh the tokens and fetch the profile again. Signing out deletes the saved tokens.

The product list uses the public `/products` endpoint, so product requests do not send the access token or trigger a token refresh while scrolling.
