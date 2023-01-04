class CreateDeathmatchSubmissions < ActiveRecord::Migration[7.0]
  def change
    create_table :deathmatch_submissions do |t|
      t.references :deathmatch, index: true, null: false
      t.references :submission, index: true, null: false
      t.timestamps
    end
  end
end
