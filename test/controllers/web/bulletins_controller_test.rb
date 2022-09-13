# frozen_string_literal: true

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'opens index page' do
    get root_path
    assert_response :success
  end

  test 'opens bulletin page' do
    get bulletin_path(bulletins(:ball))
    assert_response :success
  end

  test 'opens new bulletin page' do
    sign_in(users(:john))
    get new_bulletin_path
    assert_response :success
  end

  test 'should rise error for new page if user not signed in' do
    assert_raises Pundit::NotAuthorizedError do
      get new_bulletin_path
    end
  end

  test 'should create new bulletin' do
    sign_in(users(:john))
    new_bulletin = {
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      category_id: categories(:sport).id,
      image: fixture_file_upload('ball.png', 'image/png')
    }
    post bulletins_path, params: { bulletin: new_bulletin }
    created_bulletin = Bulletin.find_by(new_bulletin.slice(:title, :description, :category_id))
    assert created_bulletin
    assert_redirected_to profile_path
  end

  test 'should rise error for create if user not signed in' do
    assert_raises Pundit::NotAuthorizedError do
      new_bulletin = {
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.paragraph,
        category_id: categories(:sport).id,
        image: fixture_file_upload('ball.png', 'image/png')
      }
      post bulletins_path, params: { bulletin: new_bulletin }
    end
  end

  test 'should update bulletin' do
    sign_in(users(:john))
    bulletin = bulletins(:ball)
    update_bulletin_params = { title: Faker::Lorem.sentence, image: fixture_file_upload('ball.png', 'image/png') }
    patch bulletin_path(bulletin), params: { bulletin: update_bulletin_params }
    bulletin.reload
    assert bulletin.title == update_bulletin_params[:title]
    assert_redirected_to profile_path
  end

  test 'should archive bulletin' do
    sign_in(users(:john))
    bulletin = bulletins(:ball)
    patch archive_bulletin_path(bulletin)
    bulletin.reload
    assert bulletin.archived?
    assert_redirected_to profile_path
  end

  test 'should moderate bulletin' do
    sign_in(users(:john))
    bulletin = bulletins(:ball)
    patch moderate_bulletin_path(bulletin)
    bulletin.reload
    assert bulletin.under_moderation?
    assert_redirected_to profile_path
  end
end
