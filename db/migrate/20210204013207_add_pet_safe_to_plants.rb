class AddPetSafeToPlants < ActiveRecord::Migration
  def change
    add_column :plants, :pet_safe, :string
  end
end
