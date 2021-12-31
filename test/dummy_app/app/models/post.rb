class Post < ApplicationRecord
  has_many :comments

  validates :name, presence: true, uniqueness: {case_sensitive: true}
end
