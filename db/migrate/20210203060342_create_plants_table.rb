class CreatePlantsTable < ActiveRecord::Migration
  def change
    create_table :plants do |t|
      t.string :name
      t.string :nickname
      t.string :sunlight
      t.string :water
      t.string :fertilizer
      t.string :notes
    end
  end
end
