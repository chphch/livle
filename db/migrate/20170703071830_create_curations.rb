class CreateCurations < ActiveRecord::Migration[5.1]
  def change
    create_table :curations do |t|
      t.belongs_to :user
      t.string :title
      t.text :content
      t.integer :count_share
      t.integer :count_view

      t.timestamps
    end
  end
end
