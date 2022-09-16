# frozen_string_literal: true

class Web::ProfileControllerTest < ActionDispatch::IntegrationTest
  test 'opens profile page' do
    sign_in(users(:john))
    get profile_path
    assert_response :success
  end
end
