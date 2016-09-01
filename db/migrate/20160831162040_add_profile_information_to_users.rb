class AddProfileInformationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :text
    add_column :users, :second_name, :text
    add_column :users, :birthday, :date
    add_column :users, :city, :text
  end
end
