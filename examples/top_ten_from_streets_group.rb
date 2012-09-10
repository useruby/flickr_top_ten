#!/usr/bin/env ruby

__DIR__ = File.dirname(__FILE__)
flickr_keys = YAML.load_file "#{__DIR__}/../flickr_keys.yaml"

FlickrTopTen::API_KEY = flickr_keys['api_key']
FlickrTopTen::SHARED_SECRET = flickr_keys['shared_secret']

require 'flickr_top_ten'

group_ids = %w{
  355036@N23
  1576994@N21
  97329809@N00 
  71456407@N00
  77501447@N00
}

street_groups = FlickrTopTen::GroupSet.new group_ids: group_ids
photos = street_groups.ten_most_viewed_today_photos

photos.each {|photo| p photo.url(:photopage)}
