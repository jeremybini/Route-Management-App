require 'test_helper'

class WallsControllerTest < ActionController::TestCase
  setup do
    @wall = walls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:walls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wall" do
    assert_difference('Wall.count') do
      post :create, wall: { belongs_to: @wall.belongs_to, name: @wall.name, wall_image: @wall.wall_image }
    end

    assert_redirected_to wall_path(assigns(:wall))
  end

  test "should show wall" do
    get :show, id: @wall
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wall
    assert_response :success
  end

  test "should update wall" do
    patch :update, id: @wall, wall: { belongs_to: @wall.belongs_to, name: @wall.name, wall_image: @wall.wall_image }
    assert_redirected_to wall_path(assigns(:wall))
  end

  test "should destroy wall" do
    assert_difference('Wall.count', -1) do
      delete :destroy, id: @wall
    end

    assert_redirected_to walls_path
  end
end
