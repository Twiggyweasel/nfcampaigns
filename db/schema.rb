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

ActiveRecord::Schema.define(version: 20170115220338) do

  create_table "attendees", force: :cascade do |t|
    t.decimal  "fee"
    t.string   "shirt_size"
    t.boolean  "paid",       default: false
    t.integer  "team_id"
    t.integer  "event_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["event_id"], name: "index_attendees_on_event_id"
    t.index ["team_id"], name: "index_attendees_on_team_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  end

  create_table "contributions", force: :cascade do |t|
    t.decimal  "amount"
    t.string   "honoree"
    t.string   "processing"
    t.string   "backable_type"
    t.integer  "backable_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["backable_type", "backable_id"], name: "index_contributions_on_backable_type_and_backable_id"
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
    t.text     "teaser"
    t.text     "desc"
    t.date     "registration_date"
    t.date     "event_date"
    t.time     "event_start_time"
    t.integer  "goal"
    t.integer  "raised"
    t.string   "venue_name"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.boolean  "has_shirts",        default: true
    t.boolean  "is_private",        default: true
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
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

  create_table "pledge_pages", force: :cascade do |t|
    t.text    "summary"
    t.float   "goal"
    t.string  "pledge_pic"
    t.integer "attendee_id"
    t.index ["attendee_id"], name: "index_pledge_pages_on_attendee_id"
  end

  create_table "registration_fees", force: :cascade do |t|
    t.string   "name"
    t.decimal  "amount"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_registration_fees_on_event_id"
  end

  create_table "sizes", force: :cascade do |t|
    t.string "label"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "max_members"
    t.decimal  "raised"
    t.boolean  "is_private",  default: false
    t.integer  "event_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["event_id"], name: "index_teams_on_event_id"
  end

end
