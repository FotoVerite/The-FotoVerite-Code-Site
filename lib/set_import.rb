class SetImport < Struct.new(:id)

  FlickRaw.api_key ="3993b4af3ad03a4d4b40f61f9d891448"

  FlickRaw.shared_secret="fe67cf38024eb0ca"

  def self.pullSet(id)
    Delayed::Job.enqueue(SetImport.new(id))
  end

  def perform
    Dir.mkdir("tmp_set") unless File.directory?("tmp_set")
    Dir.chdir "tmp_set"
    title = flickr.photosets.getInfo(:photoset_id => id).title
    portfolio = Portfolio.new(:name => title, :description => "TODO")
    photos = flickr.photosets.getPhotos(:photoset_id => id).photo
    puts photos.size
    photos.each do |p|
      url = FlickRaw.url_b(p)
      `wget #{url}`
      image_file = File.open Dir.glob('*').first
      Photo.create(:image => image_file, :title => p.title, :portfolio => portfolio)
      File.delete Dir.glob('*').first
    end
    Dir.chdir ".."
    Dir.rmdir "tmp_set" if File.directory?("tmp_set")
  end

end
