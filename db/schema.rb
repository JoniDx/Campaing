# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_02_27_020336) do

  create_table "campaigns", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_campaigns_on_user_id"
  end

  create_table "campaings_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "campaign_id", null: false
    t.text "rol"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["campaign_id"], name: "index_campaings_users_on_campaign_id"
    t.index ["user_id"], name: "index_campaings_users_on_user_id"
  end

  create_table "user_campaings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "campaign_id", null: false
    t.text "rol"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["campaign_id"], name: "index_user_campaings_on_campaign_id"
    t.index ["user_id"], name: "index_user_campaings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "rol"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "create_by"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "voters", force: :cascade do |t|
    t.string "name"
    t.string "last_name_f"
    t.string "last_name_m"
    t.date "date_born"
    t.text "domicilio"
    t.string "clave_elector"
    t.string "estado"
    t.string "municipio"
    t.string "seccion"
    t.string "localidad"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.integer "campaign_id", null: false
    t.index ["campaign_id"], name: "index_voters_on_campaign_id"
    t.index ["user_id"], name: "index_voters_on_user_id"
  end

  add_foreign_key "campaigns", "users"
  add_foreign_key "campaings_users", "campaigns"
  add_foreign_key "campaings_users", "users"
  add_foreign_key "user_campaings", "campaigns"
  add_foreign_key "user_campaings", "users"
  add_foreign_key "voters", "campaigns"
  add_foreign_key "voters", "users"
end
