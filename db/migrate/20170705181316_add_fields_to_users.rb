class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :provider, :string
    add_column :users, :token, :string
    add_column :users, :nickname, :string
    add_column :users, :profile_img, :string
  end
end
