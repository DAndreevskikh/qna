class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  validates :title, :body, presence: true
  validates :title, presence: true
  validates :body, presence: true
end
