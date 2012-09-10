require 'flickr_top_ten/group_filters'

module FlickrTopTen
  class GroupSet
    include GroupFilters

    def initialize attrs = {}
      if attrs.has_key?(:group_ids) && !attrs[:group_ids].empty?
        @groups = attrs[:group_ids].map {|group_id| Group.new group_id: group_id}
      else
        raise Exception.new('no group in group set')
      end
    end

    def today_photos
      @groups.inject([]){|photos, group| photos + group.today_photos}
        .uniq {|photo| photo['id'] + photo['secret']}
    end
  end
end
