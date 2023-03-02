class CreateWritings < ActiveRecord::Migration[7.0]
  def change
    create_table :writings do |t|
      t.references :user, null: false, foreign_key: true, on_delete: :cascade
      
      t.timestamps
    end
  end
end
