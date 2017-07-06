class CurationComment < ApplicationRecord
  belongs_to :curation
  belongs_to :user
end
