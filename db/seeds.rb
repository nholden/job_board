# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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
