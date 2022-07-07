class ArticleCategory < ApplicationRecord
  # add many to many association for articles-categories
  belongs_to :article
  belongs_to :category
end