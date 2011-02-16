class Photo < ActiveRecord::Base

  belongs_to :portfolio, :counter_cache => true

  acts_as_list :scope => :portfolio

  attr_accessor :position_keeper


  has_attached_file :image,
    :url =>                    "/images/portfolios/:portfolio_id/photos/:style/:id/:basename.:extension",
    :path => ":rails_root/public/images/portfolios/:portfolio_id/photos/:style/:id/:basename.:extension",
    :default_url => '/images/portfolios/missing.png',
    :styles => { 
      :original => "",
      :display => '900X>',  # ideal size: 1247w x 813h
      :rep    => 'X207',
      :thumb    => 'X73' },
    :default_style => :large

  validates_attachment_presence :image, :if => Proc.new { |m| !m.image_file_name.blank? }
  validates_attachment_size :image, :less_than => 4.megabytes, :if => Proc.new { |m| !m.image_file_name.blank? }
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/jpg'], :if => Proc.new { |m| !m.image_file_name.blank? }

  default_scope :order => "photos.position ASC"

  after_create :update_position
  after_save :add_title

  def display(size="large")
    if text_only?
      description
    else
      image(size.to_sym)
    end
  end

  def update_position
    return unless self.position_keeper
    self.insert_at(position_keeper)
  end

  def add_title
    unless self.title? || self.text_only?
      self.title = self.image_file_name.gsub(/\..*?$/, "").titleize
      self.save
    end
  end



end
