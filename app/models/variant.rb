class Variant < ApplicationRecord
  belongs_to :product
  has_many :line_items
  has_one_attached :variant_image
end
