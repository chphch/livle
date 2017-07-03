class CreateCurationComments < ActiveRecord::Migration[5.1]
  def change
    create_table :curation_comments do |t|

      t.timestamps
    end
  end
end
