class CreateCurationComments < ActiveRecord::Migration[5.1]
  def change
    create_table :curation_comments do |t|
      t.belongs_to :feed
      t.belongs_to :user
      t.text :content

      t.timestamps
    end
  end
end
