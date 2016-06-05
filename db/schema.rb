# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160526191507) do

  create_table "lotteries", force: :cascade do |t|
    t.decimal  "prize_amount",    default: 0.0, null: false
    t.string   "bitcoin_address"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "winner_entry"
    t.datetime "ends_at",                       null: false
    t.string   "transaction_id"
  end

  create_table "lotteries_lottery_fees", id: false, force: :cascade do |t|
    t.integer "lottery_id"
    t.integer "lottery_fee_id"
  end

  add_index "lotteries_lottery_fees", ["lottery_fee_id"], name: "index_lotteries_lottery_fees_on_lottery_fee_id"
  add_index "lotteries_lottery_fees", ["lottery_id"], name: "index_lotteries_lottery_fees_on_lottery_id"

  create_table "lottery_entries", force: :cascade do |t|
    t.string   "bitcoin_address", null: false
    t.decimal  "amount_charged",  null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "lottery_id",      null: false
    t.integer  "user_id"
    t.string   "transaction_id",  null: false
  end

  create_table "lottery_fees", force: :cascade do |t|
    t.string  "name"
    t.decimal "amount"
    t.string  "address"
    t.boolean "default",    default: true
    t.boolean "percentage", default: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "bitcoinaddress"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
