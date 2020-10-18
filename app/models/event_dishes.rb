class EventDish < ActiveRecord::Base
    belongs_to :event
    belongs_to :dish
end