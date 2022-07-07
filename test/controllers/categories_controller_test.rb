require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  # this setup executes before any test
  setup do
    # create category object to hit database
    @category = Category.create(name: "Sports")
    # create admin user
    @admin_user = User.create(username: "johndoe", email: "johndoe@example.com",
                              password: "password", admin: true)
  end

  test "should get index" do
    # go to the categories listing page
    get categories_url
    # the browser should return the page with OK status
    assert_response :success
  end

  test "should get new" do
    # the page of creating categories available only for admin
    sign_in_as(@admin_user)
    # go to the new category form page
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    # create categories can only admin
    sign_in_as(@admin_user)
    # after the category creation total count of categories must increase by 1
    assert_difference('Category.count', 1) do
      post categories_url, params: { category: { name: "Travel" } }
    end
    # after creation the browser should redirect to the created category show page
    assert_redirected_to category_url(Category.last)
  end

  test "should not create category if not admin" do
    # after attempt of creating an invalid category total count of categories must be the same
    assert_no_difference('Category.count') do
      post categories_url, params: { category: { name: "Travel" } }
    end
    # check for redirecting to the categories listing page
    assert_redirected_to categories_url
  end

  test "should show category" do
    # go to category show page and check the path
    get category_url(@category)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  # test "should update category" do
  #   patch category_url(@category), params: { category: {  } }
  #   assert_redirected_to category_url(@category)
  # end

  # test "should destroy category" do
  #   assert_difference('Category.count', -1) do
  #     delete category_url(@category)
  #   end

  #   assert_redirected_to categories_url
  # end
end
