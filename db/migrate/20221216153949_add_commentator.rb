class AddCommentator < ActiveRecord::Migration[7.0]
  def change
    add_column :ratings, :commentator, :string
  end
end
