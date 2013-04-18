require 'faker'
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Rake::Task['db:reset'].invoke
    admin= User.create!(name: "Example User",
		 email: "example@railstutorial.org",
		 password: "foobar",
		 password_confirmation: "foobar")
    admin.toggle!(:is_admin)
    99.times do |n|
      name=Faker::Name.name
      email="example-#{n+1}@railstutorial.org"
      password="111111"
      User.create!(name: name,
		   email: email,
		   password: password,
		   password_confirmation: password)
     end
     users=User.all(limit: 6)
     50.times do
       content=Faker::Lorem.sentence(5)
       users.each { |user| user.microposts.create!(content: content)}
     end
   end
end
