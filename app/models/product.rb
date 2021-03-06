class Product < ApplicationRecord
  include Discard::Model

  has_one_attached :master_image
  has_many :variants
  has_one :master, -> { where(is_master: true) }, inverse_of: :product, class_name: 'Variant'

  validates :title, presence: { message: 'El titulo no puede estar en blanco' }
  validates :title, length: { minimum: 2, message: 'El titulo no puede contener menos de 2 letras' }

  scope :filter_by_title, ->(title) { where('title LIKE ?', "%#{title}%") }
end
