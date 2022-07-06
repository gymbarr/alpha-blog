require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
    # the first action is to go to the new category creation page
    get "/categories/new"
    assert_response :success

    # after the category creation total count of categories must increase by 1
    assert_difference('Category.count', 1) do
      # create the category by post request
      post categories_path, params: { category: { name: "Sports" } }
      # check if redirecting is the next action
      assert_response :redirect
    end
    follow_redirect!
    # check that it's right page
    assert_response :success
    # check for a category name in the code of that page
    assert_match "Sports", response.body
  end
end
