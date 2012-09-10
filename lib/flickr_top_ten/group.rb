require 'flickr_top_ten/group_filters'

module FlickrTopTen
  class Group
    include GroupFilters

    def initialize attrs = {}
      if attrs.has_key? :group_id
        @group_id = attrs[:group_id]
      else
        raise FlickrTopTen::Exception.new('group id is not set')
      end
    end

    def photos attrs = {}
      client_groups.pools.getPhotos attrs.merge(group_id: @group_id, extras: 'date_upload, views, url_n')
    end

    def today_photos
      per_page = 500
      page = 1
      all_photos = photos(per_page: per_page, page: page).select {|photo| select_today_photos(photo)}
      
      while all_photos.size == per_page*page
        page += 1
        all_photos += photos(per_page: per_page, page: page).select {|photo| select_today_photos(photo)}
      end

      all_photos
    end

    protected
    def client_groups
      Core.client.groups
    end

    def select_today_photos photo
      dateadded = Time.at(photo.dateadded.to_i)
      dateupload = Time.at(photo.dateupload.to_i)
      today = Time.now

      dateadded.day == today.day && dateadded.month == today.month && dateadded.year == today.year \
      && dateupload.day == today.day && dateupload.month == today.month && dateupload.year == today.year
    end
  end
end
