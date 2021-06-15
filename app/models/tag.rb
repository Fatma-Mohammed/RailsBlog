class Tag < ApplicationRecord
    has_many :post_tags
    has_and_belongs_to_many :posts
end
