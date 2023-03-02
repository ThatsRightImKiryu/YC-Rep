class Writing < ApplicationRecord
  has_many :ratings, dependent: :destroy
  has_many :pages, dependent: :destroy
  has_one_attached :cover
  belongs_to :user
  before_save :blank_name?, :blank_age_limit?
  has_rich_text :text
  after_commit :add_default_cover, on: %i[create update]

  validates_presence_of :genre, message: I18n.t('no_genre')
  validates_presence_of :age_limit, message: I18n.t('no_age_limit')
  validates_numericality_of :age_limit, greater_than: -1, less_than: 19, message: I18n.t('invalid_age_limit')
  validates :genre, inclusion: { in: %w[horror action_genre none fantasy comedy drama mystery romance thriller],
                                 message: I18n.t('invalid_genre') }
  def cover_thumbnail
    if cover.attached?
      cover.variant(resize_to_limit: [30, 200]).processed
    else
      '/images/default_cover.png'
    end
  end

  private

  def add_default_cover
    unless cover.attached?
      cover.attach(
        io: File.open(
          Rails.root.join(
            'public', 'images', 'default_cover.png'
          )
        ),
        filename: 'default_cover.png',
        content_type: 'image/png'
      )
    end
  end

  def blank_name?
    self.name = I18n.t(:Nameless_work) if name.blank?
  end

  def blank_age_limit?
    self.age_limit = 0 if age_limit.blank?
  end
end
