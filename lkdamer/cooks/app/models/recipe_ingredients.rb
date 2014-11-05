class RecipeIngredients < ActiveRecord::Base
  belongs_to :ingredients, :recipes
end
