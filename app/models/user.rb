class User < ApplicationRecord
    has_secure_password
    mount_uploader :image, ImageUploader
    has_many :posts
    has_many :comments
    before_validation :downcase_email
    validates :email, uniqueness: true

    private
    
    def downcase_email
      self.email = email.downcase if email.present?
    end
    
end
