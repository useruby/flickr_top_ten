require 'spec_helper'

describe FlickrTopTen::Core do
  describe '.client' do
    it 'should return flickr client' do
      FlickrTopTen::Core.client.should_not be_nil
    end
  end
end
