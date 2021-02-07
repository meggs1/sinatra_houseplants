class Plant < ActiveRecord::Base
    belongs_to :user

    validates :name, presence: true 
    validates :nickname, presence: true, uniqueness: { case_sensitive: false }
end