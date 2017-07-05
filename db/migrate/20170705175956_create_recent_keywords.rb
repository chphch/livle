class CreateRecentKeywords < ActiveRecord::Migration[5.1]
  def change
    create_table :recent_keywords do |t|
      t.belongs_to :user

      t.timestamps
    end
  end
end
