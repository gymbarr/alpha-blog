class SignUpUserTest < ActionDispatch::IntegrationTest

  # this setup executes before any test
  setup do
    # delete all users to clear test database
    User.all.each do |user|
      user.destroy
    end
  end

  test "get sign up form and create user" do
    # the first action is to go to the sign up page
    get "/signup"
    assert_response :success

    # after a user creation total count of users must increase by 1
    assert_difference('User.count', 1) do
      # create a user by post request
      post users_path, params: { user: { username: "Skydrag", email: "skydrag@gmail.com", password: "password" } }
      # check if redirecting is the next action
      assert_response :redirect
    end
    follow_redirect!
    # check for OK response from the browser
    assert_response :success
    # check for a signed up message in the response body
    assert_match "You have successfully signed up!", response.body
    # check that signed up user is now logged in
    assert session[:id] = User.last.id
  end

  test "get sign up form and reject blank credentials" do
    # the first action is to go to the new category creation page
    get "/signup"
    # check for OK response from the browser
    assert_response :success

    # after attempt of creating an invalid user total count of users must be the same
    assert_no_difference('User.count') do
      # create user by post request
      post users_path, params: { user: { username: " ", email: " ", password: " " } }
    end
    # check for alert and alert-dismissible classes in the code of the page with error
    assert_select 'div.alert'
    assert_select 'div.alert-dismissible'
  end
end