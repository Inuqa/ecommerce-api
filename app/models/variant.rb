class Variant < ApplicationRecord
  belongs_to :product
  has_one_attached :variant_image
end
