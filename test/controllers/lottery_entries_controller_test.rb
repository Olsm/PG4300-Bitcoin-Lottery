require 'test_helper'

class LotteryEntriesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @lottery_entry = lottery_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lottery_entries)
  end

  test "should create lottery_entry" do
    assert_difference('LotteryEntry.count') do
      post :create, lottery_entry: { amount_charged: @lottery_entry.amount_charged, bitcoin_address: @lottery_entry.bitcoin_address, lottery_id: @lottery_entry.lottery_id, transaction_id: @lottery_entry.transaction_id, user_id: @lottery_entry.user_id }
    end

    assert_redirected_to lottery_entry_path(assigns(:lottery_entry))
  end

  test "should update lottery_entry" do
    patch :update, id: @lottery_entry, lottery_entry: { amount_charged: @lottery_entry.amount_charged, bitcoin_address: @lottery_entry.bitcoin_address, lottery_id: @lottery_entry.lottery_id, transaction_id: @lottery_entry.transaction_id, user_id: @lottery_entry.user_id }
    assert_redirected_to lottery_entry_path(assigns(:lottery_entry))
  end

  test "should destroy lottery_entry" do
    assert_difference('LotteryEntry.count', -1) do
      delete :destroy, id: @lottery_entry
    end

    assert_redirected_to lottery_entries_path
  end
end
