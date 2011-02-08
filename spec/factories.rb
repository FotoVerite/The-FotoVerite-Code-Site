Factory.sequence :name do |n|
  "username#{n}"
end

Factory.sequence :email do |n|
  "basic_email#{n}@gmail.com"
end

Factory.define :user do |u|
  u.first_name "John"
  u.last_name "Doe"
  u.username { Factory.next(:name) }
  u.email { Factory.next(:email) }
  u.password "password"
  u.password_confirmation "password"
end

Factory.define :admin, :parent => :user do |p|
end

Factory.define :portfolio do |p|
  p.name "Kevin Pretentious"
  p.visible true
end

Factory.define :project do |p|
  p.name "Kevin Pretentious"
  p.position 1
end