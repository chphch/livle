class User < ApplicationRecord
  searchkick callbacks: :async
  has_many :curation_likes
  has_many :feeds
  has_many :feed_likes
  has_many :feed_comments
  has_many :upcoming_likes
  has_many :upcoming_comments
  has_many :connect_urls
  has_many :recent_keywords
  mount_uploader :profile_img, S3Uploader
  attr_accessor :remote_new_session

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:facebook]
  validates :email, presence: true, confirmation: true, uniqueness: true
  validates :nickname, presence: true, length: {maximum: 20}, uniqueness: true
  validates :password, presence: true, confirmation: true, on: :update_with_password

  def self.from_omniauth(auth)
    where(provider: auth.provider, email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.nickname = auth.info.name  # assuming the user model has a name
      user.remote_profile_img_url = auth.info.image.gsub('http://','https://') +
            '?type=large' # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      user.skip_confirmation!
    end
  end

  def isFacebook?
    self.provider == "facebook";
  end
end
