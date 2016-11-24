module Hashtags
  extend ActiveSupport::Concern

  included do
    HASHTAG_REGEX = /(?:(?<=\s)|^)#(\w*[A-Za-z_]+\w*)/i
    before_create :save_hashtags
    acts_as_taggable_on :tags
  end

  def save_hashtags
    tags = self.content.scan(HASHTAG_REGEX)
    self.tag_list.add(tags)
  end

  module ClassMethods
    def self.tag_counts
      Tag.select("tags.*, count(taggings.tag_id) as count").
        joins(:taggings).group("taggings.tag_id")
    end
  end
end
