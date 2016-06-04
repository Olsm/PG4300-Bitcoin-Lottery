class Lottery < ActiveRecord::Base

  has_many :entries, class_name: 'LotteryEntry'
  has_and_belongs_to_many :fees, class_name: 'LotteryFee'

  before_create :generate_bitcoin_address
  before_create :add_default_fees

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
    self.where(transaction_id: [nil, '']).each do |l|
      if l.active?
        l.update_prize
        l.update_entries
      else
        l.end
      end
    end
  end

  def update_prize
    if active?
      # Only get transactions with at least 1 confirms
      result = BlockIo.get_transactions :type => 'received', :addresses => bitcoin_address
      transactions = result['data']['txs'] if result['status'] == "success"
      transactions.keep_if {|t| t["confirmations"] > 0}

      return prize_amount if transactions.blank?

      # Sum all transaction amounts that had at least 1 confirm
      balance = 0.0
      transactions.each do |t|
        balance += t['amounts_received'].map{|x| x["amount"].to_d}.inject(0){|sum,x| sum + x }
      end

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
    update transaction_id: "none" if winner_entry.nil?
    available_balance = (BlockIo.get_address_balance :addresses => bitcoin_address)['data']['available_balance'].to_d
    send_prize if transaction_id.blank? and  available_balance >= prize_amount
    winner_entry
  end

  def qr_code
    "https://chart.googleapis.com/chart?chs=250x250&cht=qr&chl=bitcoin:#{bitcoin_address}"
  end

  private

  def add_default_fees
    LotteryFee.where(default: true).each do |fee|
      fees << fee unless fees.include? fee
    end
  end

  def generate_bitcoin_address
      self.bitcoin_address = BlockIo.get_new_address['data']['address'] if bitcoin_address.blank?
  end

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