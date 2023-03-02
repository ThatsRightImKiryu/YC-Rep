class AddColumnNameToWriting < ActiveRecord::Migration[7.0]
  def change
    add_column :writings, :name, :string
  end
end
