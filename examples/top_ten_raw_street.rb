#!/usr/bin/env ruby

__DIR__ = File.dirname(__FILE__)
flickr_keys = YAML.load_file "#{__DIR__}/../flickr_keys.yaml"


FlickrTopTen::API_KEY = flickr_keys['api_key']
FlickrTopTen::SHARED_SECRET = flickr_keys['shared_secret']

require 'flickr_top_ten'

raw_street_group = FlickrTopTen::Group.new group_id: '355036@N23'
photos = raw_street_group.ten_most_viewed_today_photos

photos.each {|photo| p photo.url(:photopage)}
