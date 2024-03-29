class TourHost < ApplicationRecord
  has_secure_password
  has_one :image, as: :imageable, dependent: :destroy
  has_many :tours, dependent: :destroy
  accepts_nested_attributes_for :image

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end
