class Event < ActiveRecord::Base
    belongs_to :user
    has_many :event_dishes
    has_many :dishes, through: :event_dishes
end
