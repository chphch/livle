class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def increase_count_view
    self.count_view += 1
    self.save
  end
end
