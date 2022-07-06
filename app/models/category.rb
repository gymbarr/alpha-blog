class Category < ApplicationRecord

  # constraints for category name length
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  # constraints for name uniqueness
  validates_uniqueness_of :name
end