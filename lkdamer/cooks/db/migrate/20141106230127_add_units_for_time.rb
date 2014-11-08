class AddUnitsForTime < ActiveRecord::Migration
  def change
    add_column :recipes, :time_units, :string
    rename_column :recipes, :time, :time_number
  end
end
