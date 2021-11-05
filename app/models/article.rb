class Article < ApplicationRecord
  validates :title, presence: true,
                    uniqueness: { case_sensitive: false }
  validates :body, presence: true

  belongs_to :user
  has_rich_text :body

  has_many :comments, dependent: :destroy
end
