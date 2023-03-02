class Follower < ApplicationRecord
  belongs_to :user
  validates_presence_of :user_id, message: I18n.t('no_user_id')
  validates_presence_of :follow_id, message: I18n.t('no_follow_id')

end
