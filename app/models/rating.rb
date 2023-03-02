class Rating < ApplicationRecord
  belongs_to :writing
  after_save :new_update_rating
  after_destroy :old_update_rating
  validates_presence_of :rate, message: I18n.t('no_rate')
  validates_presence_of :commentator, message: I18n.t('no_commentator')
  validates_numericality_of :rate, greater_than: -1, less_than: 6, message: I18n.t('invalid_rate')

  def new_update_rating
    @writing = Writing.find(writing_id)
    writing_aver = @writing.ratings.average(:rate)

    @writing.update(rating: writing_aver.blank? ? rate : writing_aver)

    @user = User.find(@writing.user_id)
    user_aver = @user.writings.average(:rating)
    @user.update(rating: user_aver.blank? ? rate : user_aver)
  end

  def old_update_rating
    @writing = Writing.find(writing_id)
    writing_aver = @writing.ratings.average(:rate)
    new_rate = writing_aver.blank? ? 0 : writing_aver
    @writing.update(rating: writing_aver || new_rate)

    @user = User.find(@writing.user_id)
    user_aver = @user.writings.average(:rating)
    new_rate = writing_aver.blank? ? 0 : user_aver

    @user.update(rating: user_aver || new_rate)
  end
end
