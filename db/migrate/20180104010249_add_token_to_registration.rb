class AddTokenToRegistration < ActiveRecord::Migration[5.1]
  def change
    add_column :registrations, :token, :string
  end
end
