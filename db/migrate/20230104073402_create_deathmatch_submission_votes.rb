class CreateDeathmatchSubmissionVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :deathmatch_submission_votes do |t|
      t.references :deathmatch_submission, index: true, null: false
      t.integer :vote, null: false
      t.timestamps
    end
  end
end
