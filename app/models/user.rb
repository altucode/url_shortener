
class User < ActiveRecord::Base
  validates :email, :presence => true, :uniqueness => true

  has_many(
    :submitted_urls,
    :class_name => "ShortenedUrl",
    :foreign_key => :id,
    :primary_key => :submitter_id
  )
end