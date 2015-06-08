# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

Experience.create([
  { label: 'Some college' },
  { label: 'Undergraduate degree' },
  { label: 'Graduate degree' },
  { label: 'Some professional experience' },
  { label: '5+ years of professional experience' }])

Term.create([
  { label: 'Internship' },
  { label: 'Full time permanent' },
  { label: 'Part time permanent' },
  { label: 'Full time temporary' },
  { label: 'Part time temporary' }])

Role.create([
  { label: 'admin' },
  { label: 'employer' }])

User.create!(name:                  "Administrator",
             email:                 "admin@admin.com",
             role:                  Role.find_or_create_by(label: 'admin'),
             password:              "admin",
             password_confirmation: "admin")

50.times do |n|
  name = Faker::Name.name
  User.create!(name:                  name,
               email:                 Faker::Internet.free_email(name),
               role:                  Role.find_or_create_by(label: 'applicant'),
               password:              "password",
               password_confirmation: "password")
end

10.times do |n|
  name = Faker::Company.name
  User.create!(name:                  name,
               email:                 Faker::Internet.email(name),
               role:                  Role.find_or_create_by(label: 'employer'),
               password:              "password",
               password_confirmation: "password")
end

50.times do |n|
  description = ""
  Faker::Lorem.paragraphs.each do |paragraph|
    description += "#{paragraph}\n\n"
  end

  employers = Role.find_by(label:'employer').users

  Job.create!(title:       Faker::Name.title,
              location:    Faker::Address.city,
              majors:      Faker::Hacker.noun,
              description: description,
              deadline:    Faker::Date.forward(60),
              salary:      "$#{Faker::Number.number(2)}K per year",
              user:        employers.offset(rand(employers.count)).first,
              experience:  Experience.offset(rand(Experience.count)).first,
              term:        Term.offset(rand(Term.count)).first)
end
