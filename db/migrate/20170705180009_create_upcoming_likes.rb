class CreateUpcomingLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :upcoming_likes do |t|
      t.belongs_to :user
      t.belongs_to :upcoming

      t.timestamps
    end
  end
end
