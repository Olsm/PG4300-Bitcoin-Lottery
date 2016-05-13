class Lottery < ActiveRecord::Base

  has_many :entries, class_name: 'LotteryEntry'

  def active?
    ends_at > Time.current
  end

  def status
    return "Completed" if transaction_id
    return "Processing" if winner_entry
    return "Drawing" unless active?
    return "Active"
  end

  def update_prize
    if active?
      result = BlockIo.get_address_balance :addresses => bitcoin_address
      balance = result['data']['available_balance']
      update prize_amount: balance if prize_amount != balance.to_d
    end
    prize_amount
  end

  def update_entries
    result = BlockIo.get_transactions :type => 'received', :addresses => bitcoin_address
    transactions = []

    transactions = result['data']['txs'] if result['status'] == "success"
    return entries if transactions.size == entries.size or not active?

    transactions.each do |t|
      if t['confirmations'] > 0 and not entries.any? { |entry| entry.transaction_id == t['txid'] }
        amount = t['amounts_received'].map {|a| a['amount'].to_d}.reduce(:+)
        entry = entries.create(lottery_id: id, transaction_id: t['txid'],
                    amount_charged: amount, bitcoin_address: t['senders'].first)
      end
    end

    entries
  end

  def end
    update winner_entry: pick_winner if winner_entry.nil?

    if transaction_id.nil?
      result = BlockIo.withdraw_from_addresses :amounts => prize_amount-0.0001, :from_addresses => bitcoin_address,
                                               :to_addresses => entries.find(winner_entry).bitcoin_address
      update transaction_id: result['data']['txid'] if result['status'] == "success"
    end

    winner_entry
  end

  private

  def pick_winner
    key_func = Proc.new{ |item| item.id }
    weight_func = Proc.new{ |item| item.amount_charged }

    pickup = Pickup.new(entries, key_func: key_func, weight_func: weight_func)
    pickup.pick
  end

end