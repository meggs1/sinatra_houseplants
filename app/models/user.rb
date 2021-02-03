class User < ActiveRecord::Base
    has_many :plants
    has_secure_password

    validates :name, presence: true
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    validates :password_digest, presence: true

    def slug
        self.name.downcase.gsub(" ","-")
    end

end