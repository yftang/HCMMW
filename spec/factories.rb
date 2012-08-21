# by using symbol ':user', we get Factory Girl to simulate the User model
FactoryGirl.define do
  factory :user do
    name                   "Eragon Tang"
    email                  "etang@example.com"
    password               "foobar"
    password_confirmation  "foobar"
  end
end

FactoryGirl.define do
  sequence :email do |n|
    "person-#{n}@example.com"
  end
end
