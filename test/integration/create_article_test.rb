require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest
  # this setup executes before any test
  setup do
    # create user
    @user = User.create(username: "johndoe", email: "johndoe@example.com",
                              password: "password")
    
    # the page of creating articles available only for logged in users
    sign_in_as(@user)
  end

  test "get new article form and create article" do
    # the first action is to go to the new article creation page
    get "/articles/new"
    assert_response :success

    # after the article creation total count of user articles must increase by 1
    assert_difference('@user.articles.count', 1) do
      # create the category by post request
      post articles_path, params: { article: { title: "Some article", description: "Some description" } }
      # check if redirecting is the next action
      assert_response :redirect
    end
    follow_redirect!
    # check for OK response from the browser
    assert_response :success
    # check for the article name in the code of that page
    assert_match "Some article", response.body
  end

  test "get new article form and reject invalid article title" do
    get "/articles/new"
    assert_response :success

    # after attempt of creating an invalid article total count of user's articles must be the same
    assert_no_difference('@user.articles.count') do
      # create the article by post request
      post articles_path, params: { article: { title: " ", description: "Some description" } }
    end
    # check for alert and alert-dismissible classes in the code of the page with error
    assert_select 'div.alert'
    assert_select 'div.alert-dismissible'
  end

  test "get new article form and reject invalid article description" do
    get "/articles/new"
    assert_response :success

    # after attempt of creating an invalid article total count of user's articles must be the same
    assert_no_difference('@user.articles.count') do
      # create the article by post request
      post articles_path, params: { article: { title: "Some article", description: " " } }
    end
    # check for alert and alert-dismissible classes in the code of the page with error
    assert_select 'div.alert'
    assert_select 'div.alert-dismissible'
  end
end