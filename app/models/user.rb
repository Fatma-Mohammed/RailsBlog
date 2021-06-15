class User < ApplicationRecord
    has_secure_password
    mount_uploader :image, ImageUploader
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    before_validation :downcase_email
    validates :email, uniqueness: true

    private
    
    def downcase_email
      self.email = email.downcase if email.present?
    end
    
end
