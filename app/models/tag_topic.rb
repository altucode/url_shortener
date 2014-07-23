class TagTopic < ActiveRecord::Base
  validates :topic, :presence => true, :uniqueness => true

  has_many(
  :tags,
  :class_name => "Tagging",
  :foreign_key => :topic_id,
  :primary_key => :id
  )

  has_many(
  :urls,
  :through => :tags,
  :source => :url
  )

  def self.add_topic(topic)
    TagTopic.create!(topic: topic)
  end

  def most_popular(n = 1)
    urls.sort_by { |url| url.num_clicks }.reverse[0...n]
  end

end