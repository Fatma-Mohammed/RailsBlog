class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :post_tags
  # has_many :tags, through: :appointments
  validates :tags,  presence: { message: "Post should have at least one tag" }


  has_and_belongs_to_many :tags


end
