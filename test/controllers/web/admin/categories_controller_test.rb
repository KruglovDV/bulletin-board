# frozen_string_literal: true

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test 'opens index page' do
    sign_in(users(:admin))
    get admin_categories_path
    assert_response :success
  end

  test 'opens new page' do
    sign_in(users(:admin))
    get new_admin_category_path
    assert_response :success
  end

  test 'should create category' do
    sign_in(users(:admin))
    new_category = { name: Faker::Name.name }
    post admin_categories_path, params: { category: new_category }
    created_category = Category.find_by(new_category)
    assert created_category
  end

  test 'opens edit page' do
    sign_in(users(:admin))
    category = categories(:sport)
    get edit_admin_category_path(category)
    assert_response :success
  end

  test 'should update category' do
    sign_in(users(:admin))
    category = categories(:sport)
    update_category_params = { name: Faker::Name.name }
    patch admin_category_path(category), params: { category: update_category_params }
    category.reload
    assert { category.name == update_category_params[:name] }
  end

  test 'should destroy category' do
    sign_in(users(:admin))
    category = categories(:sport)
    delete admin_category_path(category)
    assert_not Category.find_by(id: category.id)
  end
end
