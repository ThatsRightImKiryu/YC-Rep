# Docs
class User < ApplicationRecord
  has_many :writings, dependent: :destroy
  has_many :followers, dependent: :destroy

  has_secure_password
  validates_uniqueness_of :username, message: I18n.t('user_exist')
  validates_uniqueness_of :email, message: I18n.t('email_exist')

  validates_presence_of :username, message: I18n.t('username_empty')
  validates_presence_of :email, message: I18n.t('email_empty')
  validates_presence_of :password_digest, message: I18n.t('password_empty')

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: I18n.t(:invalid_email) }
  validates_confirmation_of :password_digest
  has_one_attached :avatar

  after_commit :add_default_avatar, on: %i[create update]

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize_to_limit: [300, 500]).processed
    else
      '/images/default_avatar.jpg'
    end
  end

  private

  def add_default_avatar
    unless avatar.attached?

      avatar.attach(
        io: File.open(Rails.root.join('public', 'images', 'default_avatar.png')),
        filename: 'default_avatar.png',
        content_type: 'image/png'
      )
    end
  end
end
