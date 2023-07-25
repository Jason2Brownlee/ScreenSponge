require 'test_helper'

class PossessionsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:possessions)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_possession
    assert_difference('Possession.count') do
      post :create, :possession => { }
    end

    assert_redirected_to possession_path(assigns(:possession))
  end

  def test_should_show_possession
    get :show, :id => possessions(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => possessions(:one).id
    assert_response :success
  end

  def test_should_update_possession
    put :update, :id => possessions(:one).id, :possession => { }
    assert_redirected_to possession_path(assigns(:possession))
  end

  def test_should_destroy_possession
    assert_difference('Possession.count', -1) do
      delete :destroy, :id => possessions(:one).id
    end

    assert_redirected_to possessions_path
  end
end
