require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!( :name                   => "Example User",
                          :email                  => "user@example.com",
                          :password               => "foobar",
                          :password_confirmation  => "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "user-#{n+1}@example.com"
      password = "password"
      User.create!( :name                   => name,
                    :email                  => email,
                    :password               => password,
                    :password_confirmation  => password)
    end
    admin.toggle!(:admin)
    User.all(:limit => 6).each do |user|
      50.times do
        user.experiments.create!(:description => Faker::Lorem.words(2).join(' '))
      end
    end
  end
end
