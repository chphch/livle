class CreateRecommendedUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :recommended_urls do |t|

      t.timestamps
    end
  end
end
