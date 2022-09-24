# frozen_string_literal: true

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'should open admin bulletins page' do
    sign_in(users(:admin))
    get admin_bulletins_path
    assert_response :success
  end

  test 'should archive bulletin' do
    sign_in(users(:admin))
    bulletin = bulletins(:car)
    patch archive_admin_bulletin_path(bulletin)
    bulletin.reload
    assert bulletin.archived?
    assert_redirected_to root_path
  end

  test 'should publish bulletin' do
    sign_in(users(:admin))
    bulletin = bulletins(:car)
    patch publish_admin_bulletin_path(bulletin)
    bulletin.reload
    assert bulletin.published?
    assert_redirected_to root_path
  end

  test 'should reject bulletin' do
    sign_in(users(:admin))
    bulletin = bulletins(:car)
    patch reject_admin_bulletin_path(bulletin)
    bulletin.reload
    assert bulletin.rejected?
    assert_redirected_to root_path
  end
end
