json.array!(@lotteries) do |lottery|
  json.extract! lottery, :id, :lottery_id, :prize_amount, :user_id, :bitcoin_address
  json.url lottery_url(lottery, format: :json)
end
