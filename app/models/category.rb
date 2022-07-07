class Category < ApplicationRecord
  # add many to many association for articles-categories
  has_many :article_categories
  has_many :articles, through: :article_categories

  # constraints for category name length
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  # constraints for name uniqueness
  validates_uniqueness_of :name
end