class RecipeForm
  attr_reader :recipe

  def initialize(attributes)
    @attributes = attributes
  end

  def save
    # create an instance of the Recipe Class
    # create recipe ingredients for each id in the ingredients key
    # create

    @recipe = new_recipe(@attributes)

    ingredient_list = @attributes[:ingredients].split(", ")


    ingredient_list.each do |ingredient|
      atts = ingredient.split(" ")
      i = Ingredient.find_by(name: atts[-1])
      unless i
        i = Ingredient.create(name: atts[-1])
      end
      RecipeIngredients.create(
        ingredient_id: i.id,
        recipe_id:     @recipe.id,
        quantity:      atts[0],
        unit:          unit_finder(atts)
        )
    end
  end

  def new_recipe(attribs)
    time = attribs[:time].split(" ")
    Recipe.new(
    name:         @attribs[:name],
    instructions: @attribs[:instructions],
    time_units:   time[1],
    time_number:  time[0]
    )
  end

  def ingredient_handling(ing_list)

  end

  def unit_finder(ar)
    ar.length == 3 ? ar[2] : nil
  end

end
