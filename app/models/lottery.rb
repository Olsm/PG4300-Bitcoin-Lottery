class Lottery < ActiveRecord::Base

  has_many :entries, class_name: 'LotteryEntry'
  has_and_belongs_to_many :fees, class_name: 'LotteryFee'

  after_create :add_default_fees

  def add_default_fees
    LotteryFee.where(default: true).each do |fee|
      fees << fee
    end
  end

  def active?
    ends_at > Time.current
  end

  def status
    return "Completed" unless transaction_id.blank?
    return "Processing" unless winner_entry.blank?
    return "Drawing" unless active?
    return "Active"
  end

  def self.update_lotteries
    self.where(transaction_id: nil).each do |l|
      l.update_entries if l.active?
      l.end unless l.active?
    end
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
    update winner_entry: pick_winner if winner_entry.blank?
    send_prize if transaction_id.blank?
    winner_entry
  end

  def qr_code
    "https://chart.googleapis.com/chart?chs=250x250&cht=qr&chl=#{bitcoin_address}"
  end

  private

  def pick_winner
    key_func = Proc.new{ |item| item.id }
    weight_func = Proc.new{ |item| item.amount_charged }

    pickup = Pickup.new(entries, key_func: key_func, weight_func: weight_func)
    pickup.pick
  end

  def send_prize
    # First amount and address the winner, total fees must be subtracted from prize
    amounts = (prize_amount - total_fee).to_s
    addresses = entries.find(winner_entry).bitcoin_address

    # Add addresses and amounts for fees that has a specified address
    percent = fees.where.not(address: [nil, '']).where(percentage: true)
    static = fees.where.not(address: [nil, '']).where(percentage: false)

    percent.zip(static).each do |p,s|
      amounts += ",#{prize_amount / 100 * p.amount}" if p
      amounts += ",#{s.amount}" if s
      addresses += ",#{p.address}" if p
      addresses += ",#{s.address}" if s
    end

    # Send transaction to the specified amounts and addresses
    result = BlockIo.withdraw_from_addresses :amounts => amounts,
                                             :from_addresses => bitcoin_address,
                                             :to_addresses => addresses
    update transaction_id: result['data']['txid'] if result['status'] == "success"
  end

  def total_fee
    percent = fees.where(percentage: true)
    static = fees.where(percentage: false)

    percent = percent.map(&:amount).inject(0, :+)
    static = static.map(&:amount).inject(0, :+)

    prize_amount * percent /100 + static
  end

end