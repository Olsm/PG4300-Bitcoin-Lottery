class Lottery < ActiveRecord::Base

  has_many :entries, class_name: 'LotteryEntry'

  def update_prize
    result = BlockIo.get_address_balance :addresses => bitcoin_address
    self.prize_amount = result['data']['available_balance']
    self.save
  end

  def update_entries
    result = BlockIo.get_transactions :type => 'received', :addresses => bitcoin_address
    transactions = []

    transactions = result['data']['txs'] if result['status'] == "success"
    return entries unless transactions.size > entries.size

    transactions.each do |t|
      unless entries.any? { |entry| entry.transaction_id == t['txid'] }
        amount = t['amounts_received'].map {|a| a['amount'].to_d}.reduce(:+)
        entry = LotteryEntry.create(lottery_id: id, transaction_id: t['txid'],
                    amount_charged: amount, bitcoin_address: t['senders'].first)
        self.entries.push entry
      end
    end

    entries
  end

  def end
    self.winner_entry = pick_winner
    #TODO: Send prize to winner
  end

  private

  def pick_winner
    key_func = Proc.new{ |item| item.id }
    weight_func = Proc.new{ |item| item.amount_charged }

    pickup = Pickup.new(entries, key_func: key_func, weight_func: weight_func)
    pickup.pick
  end

end