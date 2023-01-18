class CreateDeathmatchSubmissionVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :deathmatch_submission_votes do |t|
      t.references :deathmatch_submission, index: false, null: false
      t.integer :vote, null: false
      t.timestamps
      t.index :deathmatch_submission_id, unique: true
    end
  end
end
