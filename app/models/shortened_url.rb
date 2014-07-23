
class ShortenedUrl < ActiveRecord::Base
  validates :submitter_id, :long_url, :presence => true
  validates :short_url, :presence => true, :uniqueness => true

  belongs_to(
    :submitter,
    :class_name => "User",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    :class_name => "Visit",
    :foreign_key => :short_url_id,
    :primary_key => :id
  )

  has_many :visitors, :through => :visits, :source => :visitor

  def self.random_code
    code = SecureRandom.urlsafe_base64
    self.exists?(short_url: code) ? self.random_code : code
  end

  def self.create_for_user_and_long_url(user, long_url)
    ShortenedUrl.create!(submitter_id: user.id, long_url:long_url,
                        short_url: random_code)
  end

end