class Project < ActiveRecord::Base
  
  acts_as_list 
  acts_as_taggable_on :technologies, :features
  
  validates :name, :presence => true
  
end
