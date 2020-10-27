class User < ActiveRecord::Base
    has_secure_password
    has_many :events
    validates :name, presence: true
    validates :name, uniqueness: true
end
