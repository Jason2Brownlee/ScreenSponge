require 'test_helper'

class PlotsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:plots)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_plot
    assert_difference('Plot.count') do
      post :create, :plot => { }
    end

    assert_redirected_to plot_path(assigns(:plot))
  end

  def test_should_show_plot
    get :show, :id => plots(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => plots(:one).id
    assert_response :success
  end

  def test_should_update_plot
    put :update, :id => plots(:one).id, :plot => { }
    assert_redirected_to plot_path(assigns(:plot))
  end

  def test_should_destroy_plot
    assert_difference('Plot.count', -1) do
      delete :destroy, :id => plots(:one).id
    end

    assert_redirected_to plots_path
  end
end
