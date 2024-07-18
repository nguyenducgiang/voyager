class CreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :roles do |t|
      t.string :name, null: false, default: ""
      t.text :description, null: false, default: ""
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
