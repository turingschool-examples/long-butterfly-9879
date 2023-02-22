# Railer Coaster

This repository requires and has been tested on Ruby v2.7.4 and is based on Rails 5.2.8.

RSpec and Shoulda-Matchers have been installed and set up.

## Setup

1. Fork this repo
1. Clone your fork
1. `git clone <paste_repo>`
1. `cd <repo_name>`
1. `bundle install`
1. `rails db:{drop,create,migrate,seed}`

When you run `bundle exec rspec` you should have 2 passing tests.

## Instructions

* Work on this assessment independently. DO NOT discuss with anyone.
* You are allowed to use any references including notes, Google, lesson plans, etc.
* Read each story carefully before you start working.
* Commit Frequently, about every 15 - 30 minutes
* Push your code to your fork once the time is up (not before!)

## Submission

Once the time for the assessment is up, push your code to your fork and create a pull request to the `turingschool-examples` repository. Include the following:

* Your Name
* A reflection on how you felt you did with this challenge and what story you got through

## Requirements

* TDD all new work
* Model methods and relationships must be fully tested.

## Not Required

* No visual styling is required or expected
* You do not need to test for or create any model validations.

## Overview

We are creating an application to track the maintenance of amusement park rides and mechanics working on those rides.

* AmusementParks have a name and price of admissions attributes
  * ex. `name: 'Six Flags', admission_cost: 75`
* Mechanics have a name and years of experience attributes
  * ex. `name: ‘Kara Smith’, years_experience: 11`
* Rides have a name, thrill rating, and open (boolean) attributes
  * ex. `name: ‘The Hurler’, thrill_rating: 7, open: false`
* AmusementParks have many Rides
* Rides belong to an AmusementPark
* Mechanics can work on many Rides
* Rides can have many Mechanics working on them

Some of the initial migrations and model set up has been done for you.

## User Stories

```
Story 1 - Mechanic Show Page

As a user,
When I visit a mechanic show page
I see their name, years of experience, and the names of all rides they are working on
```

```
Story 2 - Add a Ride to a Mechanic

As a user,
When I go to a mechanic's show page
I see a form to add a ride to their workload
When I fill in that field with an id of an existing ride and click Submit
I’m taken back to that mechanic's show page
And I see the name of that newly added ride on this mechanic's show page

Ex:
Mechanic: Kara Smith
Years of Experience: 11

Current rides they’re working on:
  The Frog Hopper
  Fahrenheit
  The Kiss Raise

Add a ride to workload:
Ride Id: |_pretend_this_is_a_textfield_|
Submit
```

```
Story 3 - Amusement Park Show page

As a visitor,
When I visit an amusement park’s show page,
Then I see the name and price of admissions for that amusement park
And I see the names of all mechanics that are working on that park's rides,
And I see that the list of mechanics is unique
```

## Extensions

```
Extensions - Amusement Park's Rides

As a visitor,
When I visit an amusement park's show page,
Then I see a list of all of the park's rides,
And next to the ride name I see the average experience of the mechanics working on the ride,
And I see the list of rides is ordered by the average experience of mechanics working on the ride.
(Note: you should only perform 1 database query to retrieve the list of rides with average mechanic experience)
```
