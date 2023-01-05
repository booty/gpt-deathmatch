class CreateUniqueDeathmatchSubmissionIndex < ActiveRecord::Migration[7.0]
  def change
    add_index :deathmatch_submissions, [:deathmatch_id, :submission_id], unique: true
  end
end
