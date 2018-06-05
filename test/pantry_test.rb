require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/recipe'
require 'pry'

class PantryTest < Minitest::Test
  def setup
    @pantry = Pantry.new

  end

  def test_it_exists
    assert_instance_of Pantry, @pantry
  end

  def test_it_has_empty_stock_by_default
    assert_equal ({}), @pantry.stock
  end

  def test_it_can_check_pantry_for_items
    assert_equal 0, @pantry.stock_check('Cheese')
  end

  def test_it_can_stock_and_add_items
    @pantry.restock('Cheese', 10)
    assert_equal 10, @pantry.stock_check('Cheese')
    @pantry.restock('Cheese', 20)
    assert_equal 30, @pantry.stock_check('Cheese')
  end

  def test_it_has_empty_shopping_list_by_default
    assert_equal ({}), @pantry.shopping_list
  end

  def test_it_can_add_to_shopping_list
    r1 = Recipe.new('Cheese Pizza')
    r1.add_ingredient('Cheese', 20)
    r1.add_ingredient('Flour', 20)
    @pantry.add_to_shopping_list(r1)
    assert_equal ({ 'Cheese' => 20, 'Flour' => 20 }), @pantry.shopping_list
    r2 = Recipe.new('Spaghetti')
    r2.add_ingredient('Spaghetti Noodles', 10)
    r2.add_ingredient('Marinara Sauce', 10)
    r2.add_ingredient('Cheese', 5)
    @pantry.add_to_shopping_list(r2)
    assert_equal ({
      'Cheese' => 25,
      'Flour' => 20,
      'Spaghetti Noodles' => 10,
      'Marinara Sauce' => 10
    }), @pantry.shopping_list
  end

  def test_it_can_print_shopping_list
    r1 = Recipe.new('Cheese Pizza')
    r1.add_ingredient('Cheese', 20)
    r1.add_ingredient('Flour', 20)
    @pantry.add_to_shopping_list(r1)
    assert_equal ({ 'Cheese' => 20, 'Flour' => 20 }), @pantry.shopping_list
    r2 = Recipe.new('Spaghetti')
    r2.add_ingredient('Spaghetti Noodles', 10)
    r2.add_ingredient('Marinara Sauce', 10)
    r2.add_ingredient('Cheese', 5)
    @pantry.add_to_shopping_list(r2)
    assert_equal "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10", @pantry.print_shopping_list
  end
end
