class AddUsernameToBinaries < ActiveRecord::Migration[5.0]
  def change
    add_column :binaries, :username, :string
  end
end
