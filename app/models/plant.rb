class Plant < ActiveRecord::Base
    belongs_to :user

    validates :name, presence: true

    def slug
        self.name.downcase.gsub(" ","-")
    end

    def self.find_by_slug(slug)
        self.all.find{|item| item.slug == slug}
    end

end


