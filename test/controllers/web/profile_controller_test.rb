# frozen_string_literal: true

class Web::ProfileControllerTest < ActionDispatch::IntegrationTest
  test 'opens profile page' do
    sign_in(users(:john))
    get profile_path
    assert_response :success
  end

  test 'should rails error for index page if user is not signed in' do
    assert_raises Pundit::NotAuthorizedError do
      get profile_path
    end
  end
end
