class CreateTeammates < ActiveRecord::Migration[5.0]
  def change
    create_table :teammates ,id: false do |t|
      t.integer :user_id
      t.integer :teammate_id
      t.timestamps
    end

    add_index(:teammates, [:user_id, :teammate_id], :unique => true)
    add_index(:teammates, [:teammate_id, :user_id], :unique => true)
  end
end
