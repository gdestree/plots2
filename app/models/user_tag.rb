class UserTag < ApplicationRecord
  belongs_to :user, foreign_key: :uid

  validates :value, presence: :true
  validates :value, format: { with: /\A[\w\.:-]*\z/, message: 'can only include letters, numbers, and dashes' }

  before_save :preprocess

  def preprocess
    self.value = self.value.downcase
  end

  def self.exists?(uid, value)
    UserTag.where(uid: uid, value: value).count.positive?
  end

  def name
    self.value
  end

end
