class Portfolio < ActiveRecord::Base
  
  has_many :photos
  
  validates :name, :presence => true
  validates :description, :presence => true

  accepts_nested_attributes_for :photos, :reject_if => lambda { |t| t['image'].nil? }
  
end
