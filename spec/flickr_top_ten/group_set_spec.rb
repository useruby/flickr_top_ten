require 'spec_helper'

# Raw Street Photography - 355036@N23
# Just Street Photography - 97329809@N00

describe FlickrTopTen::GroupSet do
  describe '#initialize' do
    it 'should create a group set object' do
      FlickrTopTen::GroupSet.new(group_ids: ['355036@N23', '97329809@N00']).should_not be_nil
    end

    it 'should raise exception if no group in group set' do
      lambda {
        FlickrTopTen::GroupSet.new 
      }.should raise_exception(FlickrTopTen::Exception, 'no group in group set')
    end
  end

  context 'raw street photography and just street photography' do
    before :each do
      @group_set = FlickrTopTen::GroupSet.new(group_ids: ['355036@N23', '97329809@N00'])
    end
    
    describe '#today_photos' do
      it 'should return list of photos that was uploaded to groups today' do
        photos = @group_set.today_photos
        photos.should_not be_nil
        photos.should_not be_empty
      end

      it 'should return list where each photo have uniq id' do
        photos = @group_set.today_photos
        photos.size.should == photos.map{|photo| photo['id']}.uniq.size
      end
    end

    it_behaves_like FlickrTopTen::GroupFilters
  end
end
