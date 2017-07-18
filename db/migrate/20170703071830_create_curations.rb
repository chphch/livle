class CreateCurations < ActiveRecord::Migration[5.1]
  def change
    create_table :curations do |t|
      t.belongs_to :user
      t.string :title
      t.text :content
      t.string :youtube_id
      t.integer :count_share
      t.integer :count_view
      t.float :rank

      t.timestamps
    end
  end
end
