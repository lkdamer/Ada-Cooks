class RecipesController < ApplicationController

  def create
    @recipe_form = RecipeForm.new(params[:recipe])
    if @recipe_form.save
      redirect_to recipe_path(@recipe_form.recipe.id)
    end
  end

end
