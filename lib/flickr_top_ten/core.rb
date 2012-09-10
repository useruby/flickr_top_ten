module FlickrTopTen
  class Core
    def self.client
      unless @client
        FlickRaw.api_key = FlickrTopTen::API_KEY
        FlickRaw.shared_secret= FlickrTopTen::SHARED_SECRET

        @client = FlickRaw::Flickr.new
      end

      @client
    end
  end
end
