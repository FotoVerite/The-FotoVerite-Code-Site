class Portfolio < ActiveRecord::Base
  
  acts_as_list
  
  has_many :photos, :dependent => :destroy
  has_many :true_photos, :class_name => "Photo", :conditions => {:text_only => 0}
    
  belongs_to :rep_photo, :class_name => "Photo"
  
  validates :name, :presence => true
  validates :description, :presence => true

  accepts_nested_attributes_for :photos, :reject_if => lambda { |t| t['text_only'] ?  t['description'].nil? : t['image'].nil? }
  
end
