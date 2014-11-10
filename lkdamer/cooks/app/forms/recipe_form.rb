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

    unless @recipe.save
      redirect_to :new
    end

    ingredient_list = @attributes[:ingredients].split(", ")

    ingredient_handling(ingredient_list)
  end

  def new_recipe(attribs)
    time = attribs[:time].split(" ")
    Recipe.new(
    name:         attribs[:name],
    instructions: attribs[:instructions],
    servings:     attribs[:servings],
    time_units:   time[1],
    time_number:  time[0]
    )
  end

  def ingredient_handling(ing_list)
    ing_list.each do |ingredient|
      atts = ingredient.split(" ")
      unless i = Ingredient.find_by(name: atts[-1])
        i = Ingredient.new(name: atts[-1])
        unless i.save
          render :new
        end
      end
      RecipeIngredient.create(
        ingredient_id:  i.id,
        recipe_id:      @recipe.id,
        quantity:       atts[0],
        unit:           unit_finder(atts)
      )
    end
  end

  def unit_finder(ar)
    ar.length == 3 ? ar[1] : nil
  end

  def update #for this, attributes == params
    attribs = @attributes[:recipe]
    update_recipe(attribs)
    update_ingredients(attribs)
  end

  def update_recipe(attributes)
    time = attributes[:time].split(" ")
    @recipe = Recipe.find(@attributes[:id])
    @recipe.update(
      name:         attributes[:name],
      instructions: attributes[:instructions],
      servings:     attributes[:servings],
      time_units:   time[1],
      time_number:  time[0]
    )
  end

  def update_ingredients(attribs)
    if attribs[:new_ingredients].length > 0
      ingredient_list = attribs[:new_ingredients].split(", ")
      ingredient_handling(ingredient_list)
    end
    if ing_list = attribs[:ingredients]
      ing_list.keys.each do |r_i_id|
        r_i = RecipeIngredient.find(r_i_id)
        ing_id = ingredient_update_wrangler(r_i.ingredient, ing_list[r_i_id])
        r_i.update(
          quantity: ing_list[r_i_id][:quantity],
          unit: ing_list[r_i_id][:unit],
          ingredient_id: ing_id
        )
        if r_i.quantity == 0
          r_i.delete
        end
      end
    end
  end

  def ingredient_update_wrangler(ingredient, info)
    if ingredient.name == info[:ingredient]
      ingredient.id
    elsif ingredient.recipes.length > 1
      new_ing = Ingredient.create(info[:ingredient])
      new_ing.id
    elsif other_ingredient = Ingredient.find_by(name: info[:ingredient])
      ingredient.delete
      other_ingredient.id
    else
      ingredient.update( name: info[:ingredient])
      ingredient.save
    end
  end

end
