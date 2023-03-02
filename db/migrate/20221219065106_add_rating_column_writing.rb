class AddRatingColumnWriting < ActiveRecord::Migration[7.0]
  def change
    add_column :writings, :rating, :integer, default: 0
  end
end
