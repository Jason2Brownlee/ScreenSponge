require 'test_helper'

class FriendshipsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:friendships)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_friendships
    assert_difference('Friendships.count') do
      post :create, :friendships => { }
    end

    assert_redirected_to friendships_path(assigns(:friendships))
  end

  def test_should_show_friendships
    get :show, :id => friendships(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => friendships(:one).id
    assert_response :success
  end

  def test_should_update_friendships
    put :update, :id => friendships(:one).id, :friendships => { }
    assert_redirected_to friendships_path(assigns(:friendships))
  end

  def test_should_destroy_friendships
    assert_difference('Friendships.count', -1) do
      delete :destroy, :id => friendships(:one).id
    end

    assert_redirected_to friendships_path
  end
end
