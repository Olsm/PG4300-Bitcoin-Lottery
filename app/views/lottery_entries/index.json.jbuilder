json.array!(@lottery_entries) do |lottery_entry|
  json.extract! lottery_entry, :id, :email, :bitcoin_address, :amount_charged
  json.url lottery_entry_url(lottery_entry, format: :json)
end
