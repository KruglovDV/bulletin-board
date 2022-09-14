# frozen_string_literal: true

class Web::Admin::HomeControllerTest < ActionDispatch::IntegrationTest
  test 'opens admin home page' do
    sign_in(users(:admin))
    get admin_root_path
    assert_response :success
  end

  test 'should should redirect to root path if user is not admin' do
    sign_in(users(:john))
    get admin_root_path
    assert_redirected_to root_path
  end
end
