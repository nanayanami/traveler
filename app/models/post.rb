class Post < ApplicationRecord

    attachment :image
    belongs_to :user
     has_many :contents, dependent: :destroy
end
