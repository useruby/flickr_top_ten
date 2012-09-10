module FlickrTopTen::GroupFilters
  def ten_most_viewed_today_photos
    photos = today_photos
      .select{|photo| photo.views.to_i > 50}
      .map{|photo| FlickrTopTen::Photo.new photo_id: photo.id, secret: photo.secret}
      .sort{|photo1, photo2| photo2 <=> photo1}[0...10]
  end
end
