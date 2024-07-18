class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false, default: ""
      t.text :description, null: false, default: ""
      t.integer :owner_id, null: false

      t.timestamps
    end
    add_index :teams, :owner_id
  end
end
