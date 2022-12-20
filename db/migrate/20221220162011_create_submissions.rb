class CreateSubmissions < ActiveRecord::Migration[7.0]
  def change
    create_table :submissions do |t|
      t.references :user, null: false, index: true
      t.string :prompt, null: false
      t.string :response, null: false
      t.string :gpt_model, null: false
      t.json :response_raw, null: false
      t.timestamps
    end
  end
end
