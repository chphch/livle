class CurationLike < ApplicationRecord
  belongs_to :curation
  belongs_to :user
end
