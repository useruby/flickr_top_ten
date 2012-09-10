module FlickrTopTen
  class Photo
    include Comparable

    attr_reader :photo_id, :secret, :views, :comments

    def initialize attrs = {}
      @_info = flickr_photos.getInfo attrs 
 
      @photo_id = @_info.id
      @secret = @_info.secret
      @views = @_info.views.to_i
      @comments = @_info.comments.to_i
      @dateuploaded = Time.at(@_info.dateuploaded.to_i)
    end

    def uploaded_today?
      today = Time.now

      @dateuploaded.day == today.day && @dateuploaded.month == today.month \
      && @dateuploaded.year == today.year
    end

    def favorites
      unless @favorites
        per_page = 50
        page = 1
        favorites_count = 0

        begin
          favorites = flickr_photos.getFavorites photo_id: @photo_id, per_page: per_page, page: page
          
          page += 1
          favorites_count += favorites.person.size
        end while favorites.person.size == per_page

        @favorites = favorites_count
      end

      @favorites
    end

    def <=> photo
      popularity <=> photo.popularity 
    end

    def popularity
      favorites*0.8 + views*0.1 + comments*0.2
    end

    def url type = :photopage
      FlickRaw.url_photopage(@_info) if type == :photopage      
    end

    protected
    def flickr_photos
      Core.client.photos
    end
  end
end
