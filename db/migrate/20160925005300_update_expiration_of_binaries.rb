class UpdateExpirationOfBinaries < ActiveRecord::Migration[5.0]
  def change
    remove_column :binaries, :expiration, :string
    add_column :binaries, :expiration, :integer
  end
end
