class Curation < ApplicationRecord
  has_one :feed
  has_one :user
end
