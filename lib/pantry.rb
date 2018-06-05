class Pantry
  attr_reader :stock, :shopping_list, :cookbook

  def initialize
    @stock = {}
    @shopping_list = {}
    @cookbook = []
  end

  def stock_check(item)
    return 0 if @stock[item].nil?
    @stock[item]
  end

  def restock(item, count)
    if @stock[item].nil?
      @stock[item] = count
    else
      @stock[item] += count
    end
  end

  def add_to_shopping_list(recipe)
    recipe.ingredients.each do |item, count|
      if @shopping_list[item].nil?
        @shopping_list[item] = count
      else
        @shopping_list[item] += count
      end
    end
    @shopping_list
  end

  def print_shopping_list
    list = ''
    @shopping_list.each do |item, count|
      list += "* #{item}: #{count}\n"
    end
    print list
    list.chomp
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def what_can_i_make
    @cookbook.map do |recipe|
      available = find_available_ingredients(recipe)
      if (available & recipe.ingredients.keys) == recipe.ingredients.keys
        recipe.name
      end
    end.compact
  end

  def find_available_ingredients(recipe)
    recipe.ingredients.map do |item, count|
      next unless @stock.key?(item)
      item if @stock[item] >= count
    end
  end

  def how_many_can_i_make
    available_recipes = @cookbook.find_all do |recipe|
      recipe if what_can_i_make.include?(recipe.name)
    end
    how_many = {}
    available_recipes.each do |recipe|
      how_many[recipe.name] = find_number(recipe)
    end
    how_many
  end

  def find_number(recipe)
    number = 0
    recipe.ingredients.each do |ingredient, count|
      number = @stock[ingredient] / count if @stock[ingredient] / count > number
    end
    number
  end
end
