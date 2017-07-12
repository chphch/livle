class ConnectUrl < ApplicationRecord
  belongs_to :user
  belongs_to :feed
end
