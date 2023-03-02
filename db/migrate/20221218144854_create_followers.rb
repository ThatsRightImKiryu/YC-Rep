class CreateFollowers < ActiveRecord::Migration[7.0]
  def change
    create_table :followers do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :follow_id

      t.timestamps
    end
  end
end
