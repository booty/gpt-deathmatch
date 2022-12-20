class CreateDeathmatchVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :deathmatch_votes do |t|
      t.references :submission, index: true, null: false
      t.integer :vote, null: false
      t.timestamps
    end
  end
end
