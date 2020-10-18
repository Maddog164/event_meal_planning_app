class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :type

      t.timestamps null: false
    end

    create_table :events_dishes, id:false do |t|
      t.belongs_to :event
      t.belongs_to :dish
    end
  end
end
