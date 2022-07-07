require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: "Sports")
    @category2 = Category.create(name: "Travel")
  end 

  test "should show categories listing" do
    # go to the page of listing categories
    get "/categories"
    # look for a link with path to the created category show page with the text of the category name
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end
end
