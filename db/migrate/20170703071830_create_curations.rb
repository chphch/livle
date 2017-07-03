class CreateCurations < ActiveRecord::Migration[5.1]
  def change
    create_table :curations do |t|
      t.text :content

      t.timestamps
    end
  end
end
