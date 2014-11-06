class RecipeForm
  attr_reader :recipe

  def initialize(attributes)
    @attributes = attributes
  end

  def save
    # create an instance of the Recipe Class
    # create recipe ingredients for each id in the ingredients key
    # create
    @recipe = Recipe.create(
      name: @attributes[:name],
      description: @attributes[:description]
    )
    @attributes[:ingredients].each do |id|
      RecipeIngredient.create(ingredient_id: id, recipe_id: @recipe.id)
    end
    recipe.save
  end

end