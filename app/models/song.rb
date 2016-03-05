class Song < ActiveRecord::Base
  belongs_to :album
  belongs_to :artist
  
  validates :name, presence: true, length: { in: 5..50 }
  validates :album_id, :artist_id, presence: true

 scope :recent, -> (n) { joins(:album).where("albums.released_on > ?", 6.months.ago).
  	order("albums.released_on DESC").order("songs.id DESC").limit(n) } 

end
