class CreateEventDishes < ActiveRecord::Migration
  def change
    create_table :event_dishes, id:false do |t|
      t.belongs_to :event
      t.belongs_to :dish
    end
  end
end
