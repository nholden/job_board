# jbbrd
A simple, responsive job board that's fast and easy for board adminstrators, job seekers, and employers.

[ ![Codeship Status for nholden/job_board](https://codeship.com/projects/3ce52710-62fc-0132-c183-1a1bd55739b4/status?branch=master)](https://codeship.com/projects/52213)

## Screenshot

![Screenshot of jbbrd](https://cloud.githubusercontent.com/assets/7942714/8096438/26e993fc-0fa5-11e5-980c-6b843c8e65ed.png)

## Demo
Try jbbrd out for yourself at [http://jbbrd.nickholden.io](http://jbbrd.nickholden.io). Sign up as an applicant or employer, or try the administrator account with username admin@admin.com and password admin.

## Installation

```
git clone git://github.com/nholden/job_board.git
cd job_board
bundle install

bundle exec rake db:reset
```

## Getting started

```
rails s
```

Open your browser, navigate to localhost:3000, and follow the instructions to create an administrator account.

## Add demo data

```
bundle exec rake db:demo
```

## Testing

```
bundle exec rake
```

## Credits

This project was created by Nick Holden and is licensed under the terms of the MIT license.
