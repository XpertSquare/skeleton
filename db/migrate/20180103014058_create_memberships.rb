class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships do |t|
      t.integer :account_id
      t.integer :user_id
      t.boolean :is_active

      t.timestamps
    end
  end
end
