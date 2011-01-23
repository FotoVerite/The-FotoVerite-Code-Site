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

Factory.define :person do |p|
  p.name "Kevin Sparse"
  p.title "Head of Marketing"
  p.biography_text "This is a bio"
  p.position 1
  p.visible true
end

Factory.define :artist do |p|
  p.name "Kevin Pretentious"
  p.biography_text "This is a bio"
  p.visible true
end

Factory.define :portfolio do |p|
  p.name "Kevin Pretentious"
  p.rss_feed "http://www.feed.atom"
  p.visible true
end