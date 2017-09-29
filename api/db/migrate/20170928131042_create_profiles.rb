class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id      
      t.string :display_name
      t.string :first_name
      t.string :last_name
    end
  end
end
