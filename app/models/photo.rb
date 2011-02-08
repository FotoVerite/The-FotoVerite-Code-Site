class Photo < ActiveRecord::Base

  belongs_to :portfolio, :counter_cache => true

  acts_as_list :scope => :portfolio

  attr_accessor :position_keeper

  has_attached_file :image,
    :url =>                    "/images/:portfolio_id/photos/:style/:id/:basename.:extension",
    :path => ":rails_root/public/images/:portfolio_id/photos/:style/:id/:basename.:extension",
    :styles => { :large => 'X680>',  # ideal size: 1247w x 813h
                 :medium    => 'X407',
                 :thumb    => 'X73' },
    :default_style => :large

  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 4.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/jpg']

  default_scope :order => "photo.position ASC"

  after_create :update_position

  def update_position
    return unless self.position_keeper
    self.insert_at(position_keeper)
  end

  def after_save
    unless self.title?
      self.title = self.image_file_name.titleize
    end
  end



end
