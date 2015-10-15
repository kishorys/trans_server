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

ActiveRecord::Schema.define(version: 20151015101400) do

  create_table "batches", primary_key: "batch_id", force: true do |t|
    t.string  "name"
    t.string  "status"
    t.integer "time_created",          limit: 8
    t.integer "time_submitted",        limit: 8
    t.integer "time_received",         limit: 8
    t.integer "amount_to_be_captured", limit: 8
    t.integer "amount_to_be_refunded", limit: 8
  end

  create_table "platform_records", primary_key: "txid", force: true do |t|
    t.string "tuid"
  end

  add_index "platform_records", ["tuid"], name: "tuid_idx", using: :btree

  create_table "refunded_items", primary_key: "record_id", force: true do |t|
    t.string  "tuid"
    t.text    "items",           limit: 2147483647
    t.text    "monetary_data",   limit: 2147483647
    t.text    "ext_data",        limit: 2147483647
    t.integer "amount",          limit: 8
    t.binary  "processed",       limit: 1
    t.binary  "platform_synced", limit: 1
  end

  add_index "refunded_items", ["tuid"], name: "tuid_idx", using: :btree

  create_table "salem_capture_records", primary_key: "txid", force: true do |t|
    t.string "tuid"
  end

  add_index "salem_capture_records", ["tuid"], name: "tuid_idx", using: :btree

  create_table "tokens", primary_key: "token_id", force: true do |t|
    t.text    "token",        limit: 2147483647
    t.string  "exp_date"
    t.text    "customer_key", limit: 2147483647
    t.integer "created_at",   limit: 8
    t.integer "updated_at",   limit: 8
    t.integer "order_count",  limit: 8
    t.integer "total_amount", limit: 8
  end

  create_table "transactions", primary_key: "tuid", force: true do |t|
    t.integer "amount"
    t.text    "account_number",         limit: 2147483647
    t.text    "exp_date",               limit: 2147483647
    t.string  "zip_code"
    t.string  "method_of_payment"
    t.integer "type_of_payment"
    t.string  "tip_amount"
    t.string  "tax_amount"
    t.text    "order_data",             limit: 2147483647
    t.binary  "is_synchronous",         limit: 1
    t.text    "ext_data",               limit: 2147483647
    t.text    "token_id",               limit: 2147483647
    t.text    "swipe_data",             limit: 2147483647
    t.string  "response_reason_code"
    t.string  "response_date"
    t.string  "auth_verification_code"
    t.string  "card_security_value"
    t.string  "batch_name"
    t.integer "payment_processor"
    t.string  "mcc_code"
    t.string  "mid"
    t.string  "tid"
    t.text    "bp_username",            limit: 2147483647
    t.text    "bp_password",            limit: 2147483647
    t.text    "payment_username",       limit: 2147483647
    t.text    "payment_password",       limit: 2147483647
    t.string  "operator_id"
    t.string  "supervisor_id"
    t.string  "terminal_id"
    t.string  "venue_id"
    t.string  "venue_name"
    t.string  "venue_address"
    t.string  "venue_city"
    t.string  "venue_state"
    t.string  "venue_phone"
    t.string  "venue_zip"
    t.string  "mcc_code_resp"
    t.string  "reference_number"
    t.string  "avs"
    t.string  "julian_day"
    t.string  "batch_number"
    t.string  "transaction_class"
    t.string  "sequence_number"
    t.string  "last_action_message"
    t.integer "created_at",             limit: 8
    t.integer "authorized_at",          limit: 8
    t.integer "captured_at",            limit: 8
    t.integer "reversed_at",            limit: 8
    t.integer "refunded_at",            limit: 8
    t.integer "platform_update_at",     limit: 8
    t.integer "updated_at",             limit: 8
    t.integer "local_created_at",       limit: 8
    t.string  "local_order_id"
    t.string  "cc_mask"
    t.string  "cc_bin"
    t.binary  "is_sale",                limit: 1
    t.binary  "is_swiped",              limit: 1
    t.integer "status"
    t.integer "platform_status"
  end

  create_table "transactions_reference", force: true do |t|
    t.string  "tuid"
    t.integer "amount"
    t.string  "auth_verification_code"
    t.string  "mid"
    t.text    "order_data",             limit: 2147483647
  end

  add_index "transactions_reference", ["auth_verification_code"], name: "auth_verification_code_idx", using: :btree
  add_index "transactions_reference", ["tuid"], name: "tuid_idx", using: :btree

end
