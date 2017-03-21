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

ActiveRecord::Schema.define(version: 20170321014603) do

  create_table "applications", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "event_type"
    t.string   "city"
    t.string   "state"
    t.text     "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attendees", force: :cascade do |t|
    t.float    "fee"
    t.string   "shirt_size"
    t.string   "business_name"
    t.string   "business_logo"
    t.string   "category"
    t.integer  "guest_limit"
    t.boolean  "paid",          default: false
    t.boolean  "is_leader",     default: false
    t.float    "raised"
    t.integer  "team_id"
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["event_id"], name: "index_attendees_on_event_id"
    t.index ["team_id"], name: "index_attendees_on_team_id"
    t.index ["user_id"], name: "index_attendees_on_user_id"
  end

  create_table "authentications", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "champions", force: :cascade do |t|
    t.string   "name"
    t.string   "champion_image"
    t.integer  "age"
    t.text     "story"
    t.float    "raised"
    t.boolean  "active",         default: true
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "event_id"
    t.index ["event_id"], name: "index_champions_on_event_id"
    t.index ["user_id"], name: "index_champions_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contributions", force: :cascade do |t|
    t.float    "amount"
    t.string   "honoree"
    t.string   "payment_channel"
    t.string   "category"
    t.boolean  "paid",            default: false
    t.string   "backable_type"
    t.integer  "backable_id"
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["backable_type", "backable_id"], name: "index_contributions_on_backable_type_and_backable_id"
    t.index ["user_id"], name: "index_contributions_on_user_id"
  end

  create_table "event_sizes", force: :cascade do |t|
    t.integer "size_id"
    t.integer "event_id"
    t.index ["event_id"], name: "index_event_sizes_on_event_id"
    t.index ["size_id"], name: "index_event_sizes_on_size_id"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "event_cover"
    t.string   "event_card"
    t.string   "event_type"
    t.string   "gallery"
    t.text     "teaser"
    t.text     "desc"
    t.date     "registration_date"
    t.date     "event_date"
    t.time     "event_start_time"
    t.time     "event_end_time"
    t.float    "goal"
    t.float    "raised"
    t.string   "venue_name"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.boolean  "has_shirts",                default: true
    t.boolean  "is_private",                default: true
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "title"
    t.boolean  "has_external_registration", default: false
    t.string   "external_url"
    t.string   "organizer_url"
    t.string   "organizer_logo"
    t.string   "social_image"
    t.text     "social_desc"
  end

  create_table "guests", force: :cascade do |t|
    t.string   "name"
    t.decimal  "fee"
    t.string   "shirt_size"
    t.string   "email"
    t.integer  "attendee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["attendee_id"], name: "index_guests_on_attendee_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "last4"
    t.string   "promo_code"
    t.integer  "confirmation_number"
    t.float    "amount"
    t.boolean  "success"
    t.boolean  "cover_processing"
    t.string   "authorization_code"
    t.string   "payable_type"
    t.integer  "payable_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["payable_type", "payable_id"], name: "index_payments_on_payable_type_and_payable_id"
  end

  create_table "pledge_pages", force: :cascade do |t|
    t.string  "nf_connection"
    t.text    "custom_story"
    t.float   "goal"
    t.string  "pledge_pic"
    t.boolean "has_custom"
    t.boolean "has_customized"
    t.integer "attendee_id"
    t.index ["attendee_id"], name: "index_pledge_pages_on_attendee_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "street"
    t.string   "apt"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "referral_code"
    t.string   "phone"
    t.boolean  "has_nf"
    t.boolean  "child_with_nf"
    t.boolean  "event_notifications"
    t.boolean  "news_letter"
    t.boolean  "is_private",          default: false
    t.integer  "user_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "promo_cards", force: :cascade do |t|
    t.string   "image"
    t.string   "background_image"
    t.string   "align_image"
    t.integer  "text"
    t.integer  "event_id"
    t.integer  "promotion_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["event_id"], name: "index_promo_cards_on_event_id"
    t.index ["promotion_id"], name: "index_promo_cards_on_promotion_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "code"
    t.float    "discount"
    t.date     "start"
    t.date     "stop"
    t.boolean  "is_active",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "referrals", force: :cascade do |t|
    t.string   "referral_code"
    t.string   "email"
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["team_id"], name: "index_referrals_on_team_id"
    t.index ["user_id"], name: "index_referrals_on_user_id"
  end

  create_table "registration_fees", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.integer  "guest_limit"
    t.float    "amount"
    t.text     "description"
    t.integer  "event_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["event_id"], name: "index_registration_fees_on_event_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string   "name"
    t.string   "attachment"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_resources_on_event_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
  end

  create_table "sizes", force: :cascade do |t|
    t.string "label"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "team_photo"
    t.float    "goal"
    t.integer  "max_members"
    t.float    "raised"
    t.boolean  "is_private",  default: false
    t.integer  "event_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["event_id"], name: "index_teams_on_event_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "profile_pic"
    t.integer  "role_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.index ["role_id"], name: "index_users_on_role_id"
  end

end
