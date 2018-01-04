class AddStatusToRegistrations < ActiveRecord::Migration[5.1]
  def change
    add_column :registrations, :status, :string
  end
end
