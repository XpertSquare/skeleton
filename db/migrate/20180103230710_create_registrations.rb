class CreateRegistrations < ActiveRecord::Migration[5.1]
  def change
    create_table :registrations do |t|
      t.string :name
      t.string :business_name
      t.string :email
      t.string :ip_address
      t.string :user_agent

      t.timestamps
    end
  end
end
