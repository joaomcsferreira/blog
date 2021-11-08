class Role < ApplicationRecord
    has_many :users, dependent: :restrict_with_exception

    validates :name, presence: true
    validates :description, presence: true
end
