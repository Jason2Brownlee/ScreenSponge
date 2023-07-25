require 'test_helper'

class ShowsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:shows)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_shows
    assert_difference('Shows.count') do
      post :create, :shows => { }
    end

    assert_redirected_to shows_path(assigns(:shows))
  end

  def test_should_show_shows
    get :show, :id => shows(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => shows(:one).id
    assert_response :success
  end

  def test_should_update_shows
    put :update, :id => shows(:one).id, :shows => { }
    assert_redirected_to shows_path(assigns(:shows))
  end

  def test_should_destroy_shows
    assert_difference('Shows.count', -1) do
      delete :destroy, :id => shows(:one).id
    end

    assert_redirected_to shows_path
  end
end
