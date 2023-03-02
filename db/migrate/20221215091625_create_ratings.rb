class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.integer :rate, default: 0
      t.text :comment
      t.references :writing, null: false, foreign_key: true
      t.timestamps
    end
  end
end
