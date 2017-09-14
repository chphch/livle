class AddImageUrlToTemporaryUpcomings < ActiveRecord::Migration[5.1]
  def change
    add_column :temporary_upcomings, :image_url, :string
  end
end
