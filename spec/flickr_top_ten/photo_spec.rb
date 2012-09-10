require 'spec_helper'

describe FlickrTopTen::Photo do
  before :each do
    @photo = FlickrTopTen::Photo.new photo_id: '7863598172', secret: '99a679ffe4'
  end

  describe '#initialize' do
    it 'should create a new photo object' do
      @photo.should_not be_nil
      @photo.photo_id.should == '7863598172'
      @photo.secret.should == '99a679ffe4'
      @photo.views.should > 0
      @photo.comments.should > 0
    end
  end

  describe '#uploaded_today?' do
    it 'should return true if photo was uploaded today' do
      Timecop.freeze(Time.local(2012, 'aug', 26, 10)) do
        @photo.should be_uploaded_today
      end
    end

    it 'should  return false if photo was uploaded not today' do
      @photo.should_not be_uploaded_today
    end
  end

  describe '#favorites' do
    it 'should return count of favorites for selected photo' do
      @photo.favorites.should > 0
    end
  end

  describe '#<=>' do
    it 'should return -1 if another photo has more favorites, views and comments' do
      photo = FlickrTopTen::Photo.new photo_id: '7724668216', secret: 'de43a60894'

      (@photo <=> photo).should == -1
    end

    it 'should return 1 if another photo has less favorites, views and comments' do
     photo = FlickrTopTen::Photo.new photo_id: '7614778386', secret: '875748a57e'
    
     (@photo <=> photo).should == 1
    end

    it 'should return 0 if another photo has same counts of favorites, views and comments' do
      (@photo <=> @photo).should == 0
    end
  end

  describe '#url' do
    it 'should return url for photopage' do
      @photo.url.should == 'http://www.flickr.com/photos/69546369@N08/7863598172'
    end
  end
end
