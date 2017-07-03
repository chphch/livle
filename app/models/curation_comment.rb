class CurationComment < ApplicationRecord
  belongs_to :feed
  belongs_to :user
end
