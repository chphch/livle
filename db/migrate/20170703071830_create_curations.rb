class CreateCurations < ActiveRecord::Migration[5.1]
  def change
    create_table :curations do |t|

      t.timestamps
    end
  end
end
