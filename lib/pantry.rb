require 'pry'

class Pantry
  attr_reader :stock, :shopping_list

  def initialize
    @stock = {}
    @shopping_list = {}
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
end
