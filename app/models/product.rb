class Product < ApplicationRecord
  has_one_attached :master_image
  has_many :variants
  has_one :master, -> { where(is_master: true) }, inverse_of: :product, class_name: 'Variant'

  scope :filter_by_title, ->(title) { where('title LIKE ?', "%#{title}%") }
end
