class RemoveTokenFromRegistrations < ActiveRecord::Migration[5.1]
  def change
     remove_column :registrations, :token
  end
end
