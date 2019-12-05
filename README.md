![Namer by OpenPace](https://github.com/edance/art/blob/master/namer/demo.gif)

# Emojify Your Strava Activity

[![Build Status](https://travis-ci.org/edance/namer.svg?branch=master)](https://travis-ci.org/edance/namer)
[![Coverage Status](https://coveralls.io/repos/github/edance/namer/badge.svg?branch=master)](https://coveralls.io/github/edance/namer?branch=master)
[![license](https://img.shields.io/github/license/edance/openpace.svg)](https://github.com/edance/namer/blob/master/LICENSE.md)

## What is this?

This is the repository for [openpace.co/namer](https://www.openpace.co/namer).
It is built in [Elixir](http://elixir-lang.org/) using the [Phoenix](http://www.phoenixframework.org/) web framework.
I used [cloudflare workers](https://workers.cloudflare.com/) to reverse proxy this small app onto the openpace domain.

## What does it do?

This app emojifies your Strava activities.
No more seeing something like `Morning Activity`.
This will automatically be converted to `🧘 1hr Morning Yoga`.

## Can I add an emoji?

Yes please!
You can see a list of all the emojis used [here](https://github.com/edance/namer/blob/master/lib/namer/emoji_formatter.ex#L6-L44).
If you would like to add another one, please open a pull request.

### Contributing

To start your Phoenix server:

  * Copy `.env.example` file to `.env` with `cp .env.example .env`
  * Create an app for strava [here](https://developers.strava.com).
  * Import your environment variables with `export $(cat .env | grep -v ^# | xargs)`
  * Set environment variables in your `.env` file.
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && yarn install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Feedback

Please email us with any ideas, bugs, suggestions at feedback AT openpace.co.
