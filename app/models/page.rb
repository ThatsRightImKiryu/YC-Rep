class Page < ApplicationRecord
  belongs_to :writing
  has_rich_text :text
  before_save :update_writing
  before_destroy :update_writing_after_delete

  def update_writing
    @writing = Writing.find(writing_id)
    number_of_pages = @writing.number_of_pages
    @writing.update(number_of_pages: number_of_pages + 1)
  end

  def update_writing_after_delete
    @writing = Writing.find(writing_id)
    @writing.update(number_of_pages: @writing.number_of_pages - 1)
  end
end
