class Project < ActiveRecord::Base
  
  acts_as_list 
  acts_as_taggable_on :technologies, :features
  
  validates :name, :presence => true
  
  
  has_attached_file :photo,
    :url =>                    "/images/projects-photos/:style/:id/:basename.:extension",
    :path => ":rails_root/public/images/projects-photos/:style/:id/:basename.:extension",
    :styles => { :large => "358x", :thumb => '220x130' },
    :default_style => :large
  
end
