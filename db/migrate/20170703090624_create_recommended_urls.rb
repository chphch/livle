class CreateRecommendedUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :recommended_urls do |t|
      t.belongs_to :user
      t.string :name
      t.boolean :image_url

      t.timestamps
    end
  end
end
