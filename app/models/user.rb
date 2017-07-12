class User < ApplicationRecord
  has_many :curation_likes
  has_many :feeds
  has_many :feed_likes
  has_many :feed_comments
  has_many :upcoming_likes
  has_many :upcoming_comments
  has_many :recommended_urls
  has_many :recent_keywords

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

end
