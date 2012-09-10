require 'spec_helper'

# Raw Street Photography - 355036@N23

describe FlickrTopTen::Group do
  describe '#initialize' do
    it 'should create a new object for group with selected id' do
      FlickrTopTen::Group.new(group_id: '355036@N23').should_not be_nil
    end

    it 'should raise exception if group id is not set' do
      lambda{
        FlickrTopTen::Group.new
      }.should raise_exception(FlickrTopTen::Exception, 'group id is not set')
    end
  end

  context 'group raw street photography' do
    before :each do
      @group = FlickrTopTen::Group.new group_id: '355036@N23'
    end

    describe '#photos' do
      it 'should return first 100 photos from group pool' do
        photos = @group.photos
        photos.should_not be_nil
        photos.size.should == 100
        photos.first.id.should_not be_nil
      end
    end

    describe '#today_photos' do
      it 'should return all photos that was uploaded today' do
        photos = @group.today_photos
        photos.should_not be_nil
        photos.size.should > 0

        today = Time.now

        photos.each do |photo| 
          dateadded = photo.dateadded.to_i
          Time.at(dateadded).day.should == today.day
          Time.at(dateadded).month.should == today.month
          Time.at(dateadded).year.should == today.year
        end
      end
    end

    it_behaves_like FlickrTopTen::GroupFilters
  
  end
end
