class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :binary, foreign_key: true
      t.integer :value
      t.integer :user_id

      t.timestamps
    end
  end
end
