class AddCurrentTeamIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :current_team_id, :integer
  end
end
