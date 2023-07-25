require 'test_helper'

class CoversControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:covers)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_cover
    assert_difference('Cover.count') do
      post :create, :cover => { }
    end

    assert_redirected_to cover_path(assigns(:cover))
  end

  def test_should_show_cover
    get :show, :id => covers(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => covers(:one).id
    assert_response :success
  end

  def test_should_update_cover
    put :update, :id => covers(:one).id, :cover => { }
    assert_redirected_to cover_path(assigns(:cover))
  end

  def test_should_destroy_cover
    assert_difference('Cover.count', -1) do
      delete :destroy, :id => covers(:one).id
    end

    assert_redirected_to covers_path
  end
end
