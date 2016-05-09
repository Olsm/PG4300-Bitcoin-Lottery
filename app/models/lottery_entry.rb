class LotteryEntry < ActiveRecord::Base
  after_validation :update_price, on: [:create, :update, :destroy]

  belongs_to :lottery

  def update_price
    lottery.update_prize
  end

  end
