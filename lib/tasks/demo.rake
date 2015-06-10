namespace :db do

  task :demo => :environment do
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
  end
end
