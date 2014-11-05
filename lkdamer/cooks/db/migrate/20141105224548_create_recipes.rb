class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :instructions
      t.integer :servings
      t.integer :time

      t.timestamps
    end
  end
end
