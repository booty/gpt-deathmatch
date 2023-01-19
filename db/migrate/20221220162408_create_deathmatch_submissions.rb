class CreateDeathmatchSubmissions < ActiveRecord::Migration[7.0]
  def change
    create_table :deathmatch_submissions do |t|
      t.references :deathmatch, index: true, null: false
      t.references :submission, index: true, null: false
      t.integer :vote, null: true
      t.timestamps
      t.index [:deathmatch_id, :submission_id], unique: true
    end
  end
end
