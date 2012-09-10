require 'flickr_top_ten/group_filters'

shared_examples_for FlickrTopTen::GroupFilters do
  describe '#ten_most_viewed_today_photos' do
    it 'should return 10 most viewed today photos' do
      photos = nil

      Benchmark.realtime {
        photos = (@group_set || @group).ten_most_viewed_today_photos
      }.should < 100

      photos.size == 10
      photos[0].popularity.should > photos[1].popularity
      photos[1].popularity.should > photos[2].popularity
    end
  end
end
