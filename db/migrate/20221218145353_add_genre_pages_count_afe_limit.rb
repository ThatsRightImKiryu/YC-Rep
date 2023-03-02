class AddGenrePagesCountAfeLimit < ActiveRecord::Migration[7.0]
  def change
    add_column :writings, :genre, :string
    add_column :writings, :age_limit, :integer
    add_column :writings, :number_of_pages, :integer, default: 1
  end
end
