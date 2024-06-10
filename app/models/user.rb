class User < ApplicationRecord
    include ActiveModel::Serialization
    has_secure_password
    validates :email, uniqueness: true
    has_one_attached :image,:dependent => :destroy
    has_many :posts,:dependent => :destroy

    def welcome
        "#{self.image}"
        "Username: #{self.email}"
    end
    
    def capitalized_name
        name.capitalize
    end
end
