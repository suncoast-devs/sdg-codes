class Link < ApplicationRecord
  belongs_to :user
  has_many :clicks

  validates :label, presence: true
  validates :slug, presence: true
  validates :url, presence: true
end
