class CreateUserProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_profiles do |t|
      t.text :first_name
      t.text :second_name
      t.text :city
      t.date :birthday

      t.timestamps
    end
    add_reference :user_profiles, :user, foreign_key: true
  end
end
