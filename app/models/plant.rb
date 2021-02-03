class Plant < ActiveRecord::Base
    belongs_to :user

    validates :name, presence: true
    validates :nickname, presence: true, uniqueness: { case_sensitive: false }

    def slug
        self.nickname.downcase.gsub(" ","-")
    end

    def self.find_by_slug(slug)
        self.all.find{|item| item.slug == slug}
    end

end


