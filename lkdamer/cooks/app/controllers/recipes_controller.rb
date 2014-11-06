class RecipesController < ApplicationController

  def create
    raise params
    @recipe_form = RecipeForm.new(params[:recipe_form])
    if @recipe_form.save
      redirect_to recipe_path(@recipe_form.recipe.id)
    end
  end

end
