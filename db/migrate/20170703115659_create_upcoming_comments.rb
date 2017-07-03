class CreateUpcomingComments < ActiveRecord::Migration[5.1]
  def change
    create_table :upcoming_comments do |t|

      t.timestamps
    end
  end
end
