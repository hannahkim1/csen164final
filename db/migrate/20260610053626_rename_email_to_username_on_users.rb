class RenameEmailToUsernameOnUsers < ActiveRecord::Migration[8.1]
  def change
    remove_index :users, :email
    rename_column :users, :email, :username
    add_index :users, :username, unique: true
  end
end
