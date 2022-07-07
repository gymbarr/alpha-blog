require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  # this setup executes before any test
  setup do
    # create admin user
    @admin_user = User.create(username: "johndoe", email: "johndoe@example.com",
                              password: "password", admin: true)
    
    # the page of creating categories available only for admin
    sign_in_as(@admin_user)
  end

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

  test "get new category form and reject invalid category submission" do
    # the first action is to go to the new category creation page
    get "/categories/new"
    # check for OK response from the browser
    assert_response :success

    # after attempt of creating an invalid category total count of categories must be the same
    assert_no_difference('Category.count') do
      # create the category by post request
      post categories_path, params: { category: { name: " " } }
    end
    # check for alert and alert-dismissible classes in the code of the page with error
    assert_select 'div.alert'
    assert_select 'div.alert-dismissible'
  end
end
