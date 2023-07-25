require 'test_helper'

class IntentionsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:intentions)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_intention
    assert_difference('Intention.count') do
      post :create, :intention => { }
    end

    assert_redirected_to intention_path(assigns(:intention))
  end

  def test_should_show_intention
    get :show, :id => intentions(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => intentions(:one).id
    assert_response :success
  end

  def test_should_update_intention
    put :update, :id => intentions(:one).id, :intention => { }
    assert_redirected_to intention_path(assigns(:intention))
  end

  def test_should_destroy_intention
    assert_difference('Intention.count', -1) do
      delete :destroy, :id => intentions(:one).id
    end

    assert_redirected_to intentions_path
  end
end
