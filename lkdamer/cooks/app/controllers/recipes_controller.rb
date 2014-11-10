class RecipesController < ApplicationController

  def create
    @recipe_form = RecipeForm.new(params[:recipe])
    if @recipe_form.save
      redirect_to recipe_path(@recipe_form.recipe.id)
    end
  end

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @recipe_ingredients = @recipe.recipe_ingredients
  end

  def update
    @recipe_update = RecipeForm.new(params)
    @recipe_update.update
    redirect_to @recipe_update.recipe
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe_ingredients = @recipe.recipe_ingredients
    @recipe_ingredients.each {|r_i| r_i.delete}
    @recipe.delete
    redirect_to recipes_path
  end

end
