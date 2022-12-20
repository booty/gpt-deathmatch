class CreateDeathmatches < ActiveRecord::Migration[7.0]
  def change
    create_table :deathmatches do |t|
      t.references :user, null: false
      t.timestamps
    end
  end
end
