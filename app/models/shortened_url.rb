
class ShortenedUrl < ActiveRecord::Base

  belongs_to(
    :submitter,
    :class_name => "User",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  def initialize(options = {})
    @submitter_id = options[:submitter_id]
    @long_url = options[:long_url]
    @short_url = options[:short_url]
  end

  def self.random_code
    code = SecureRandom.urlsafe_base64
    self.exists?(short_url: code) ? self.random_code : code
  end

  def self.create_for_user_and_long_url(user, long_url)
    ShortenedUrl.create!(submitter_id: user.id, long_url:long_url,
                        short_url: random_code)
  end

end