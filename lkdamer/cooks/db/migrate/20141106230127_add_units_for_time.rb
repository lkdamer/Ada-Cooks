class AddUnitsForTime < ActiveRecord::Migration
  def change
    add_column :recipe, :time_units, :string
    rename_column :recipe, :time, :time_number
  end
end
