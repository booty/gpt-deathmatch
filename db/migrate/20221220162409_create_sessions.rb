class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.references :user, null: false
      t.string :guid, index: true, null: false
      t.string :ip_address, null: false
      t.timestamps
    end
  end
end
