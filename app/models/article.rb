class Article < ApplicationRecord
  # add one to many association for user-articles
  belongs_to :user
  # add many to many association for articles-categories
  has_many :article_categories
  has_many :categories, through: :article_categories

  # constraint for article's title length
  validates :title, presence: true, length: { minimum: 6, maximum: 100 }
  # constraint for article's description length
  validates :description, presence: true, length: { minimum: 10, maximum: 2000 }
end