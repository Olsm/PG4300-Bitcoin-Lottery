require 'test_helper'

class LotteriesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @lottery = lotteries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lotteries)
  end

  test "should create lottery" do
    assert_difference('Lottery.count') do
      post :create, lottery: { bitcoin_address: @lottery.bitcoin_address, ends_at: @lottery.ends_at, prize_amount: @lottery.prize_amount, transaction_id: @lottery.transaction_id, winner_entry: @lottery.winner_entry }
    end

    assert_redirected_to lottery_path(assigns(:lottery))
  end

  test "should show lottery" do
    get :show, id: @lottery
    assert_response :success
  end

  test "should update lottery" do
    patch :update, id: @lottery, lottery: { bitcoin_address: @lottery.bitcoin_address, ends_at: @lottery.ends_at, prize_amount: @lottery.prize_amount, transaction_id: @lottery.transaction_id, winner_entry: @lottery.winner_entry }
    assert_redirected_to lottery_path(assigns(:lottery))
  end

  test "should destroy lottery" do
    assert_difference('Lottery.count', -1) do
      delete :destroy, id: @lottery
    end

    assert_redirected_to lotteries_path
  end
end
