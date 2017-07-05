class CreateUpcomingComments < ActiveRecord::Migration[5.1]
  def change
    create_table :upcoming_comments do |t|
      t.belongs_to :upcoming
      t.belongs_to :user
      t.string :content

      t.timestamps
    end
  end
end
