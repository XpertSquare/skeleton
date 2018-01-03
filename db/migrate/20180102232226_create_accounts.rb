class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :subdomain
      t.string :timezone
      t.integer :billing_cycle_code

      t.timestamps
    end
  end
end
