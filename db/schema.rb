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

ActiveRecord::Schema[8.0].define(version: 2025_04_13_183618) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.jsonb "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "bed_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_bed_types_on_name", unique: true
  end

  create_table "beds", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.string "number", limit: 20, null: false
    t.bigint "bed_type_id", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bed_type_id"], name: "index_beds_on_bed_type_id"
    t.index ["company_id"], name: "index_beds_on_company_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "state_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "cnpj", limit: 20
    t.string "email", null: false
    t.string "name", null: false
    t.string "fantasy_name", null: false
    t.string "address", null: false
    t.string "address_number", null: false
    t.string "district", null: false
    t.bigint "city_id"
    t.bigint "state_id"
    t.string "zipcode"
    t.string "phone", null: false
    t.bigint "company_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_companies_on_city_id"
    t.index ["company_type_id"], name: "index_companies_on_company_type_id"
    t.index ["state_id"], name: "index_companies_on_state_id"
  end

  create_table "company_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "consultation_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_consultation_types_on_name", unique: true
  end

  create_table "consultations", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "professional_id", null: false
    t.bigint "company_id", null: false
    t.bigint "consultation_type_id", null: false
    t.date "date", null: false
    t.time "start_time", null: false
    t.time "end_time"
    t.string "status", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_consultations_on_company_id"
    t.index ["consultation_type_id"], name: "index_consultations_on_consultation_type_id"
    t.index ["patient_id"], name: "index_consultations_on_patient_id"
    t.index ["professional_id"], name: "index_consultations_on_professional_id"
  end

  create_table "exam_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_exam_types_on_name", unique: true
  end

  create_table "exams", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "professional_id", null: false
    t.bigint "company_id", null: false
    t.bigint "exam_type_id", null: false
    t.bigint "consultation_id"
    t.date "scheduled_date", null: false
    t.date "result_date"
    t.string "status", null: false
    t.text "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_exams_on_company_id"
    t.index ["consultation_id"], name: "index_exams_on_consultation_id"
    t.index ["exam_type_id"], name: "index_exams_on_exam_type_id"
    t.index ["patient_id"], name: "index_exams_on_patient_id"
    t.index ["professional_id"], name: "index_exams_on_professional_id"
  end

  create_table "hospitalizations", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "professional_id", null: false
    t.bigint "bed_id", null: false
    t.bigint "company_id", null: false
    t.date "admission_date", null: false
    t.date "discharge_date"
    t.text "reason", null: false
    t.string "status", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bed_id"], name: "index_hospitalizations_on_bed_id"
    t.index ["company_id"], name: "index_hospitalizations_on_company_id"
    t.index ["patient_id"], name: "index_hospitalizations_on_patient_id"
    t.index ["professional_id"], name: "index_hospitalizations_on_professional_id"
  end

  create_table "medical_records", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "professional_id", null: false
    t.bigint "company_id", null: false
    t.bigint "consultation_id"
    t.date "date", null: false
    t.text "notes", null: false
    t.text "diagnosis"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_medical_records_on_company_id"
    t.index ["consultation_id"], name: "index_medical_records_on_consultation_id"
    t.index ["patient_id"], name: "index_medical_records_on_patient_id"
    t.index ["professional_id"], name: "index_medical_records_on_professional_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.text "message", null: false
    t.boolean "read", default: false
    t.datetime "sent_at", null: false
    t.string "delivery_channel", null: false
    t.string "context_type"
    t.integer "context_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["context_type", "context_id"], name: "index_notifications_on_context_type_and_context_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "prescriptions", force: :cascade do |t|
    t.bigint "consultation_id", null: false
    t.bigint "professional_id", null: false
    t.bigint "patient_id", null: false
    t.bigint "company_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_prescriptions_on_company_id"
    t.index ["consultation_id"], name: "index_prescriptions_on_consultation_id"
    t.index ["patient_id"], name: "index_prescriptions_on_patient_id"
    t.index ["professional_id"], name: "index_prescriptions_on_professional_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name", null: false
    t.string "acronym", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "phone"
    t.bigint "company_id"
    t.bigint "role_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "beds", "bed_types"
  add_foreign_key "beds", "companies"
  add_foreign_key "cities", "states"
  add_foreign_key "companies", "cities"
  add_foreign_key "companies", "company_types"
  add_foreign_key "companies", "states"
  add_foreign_key "consultations", "companies"
  add_foreign_key "consultations", "consultation_types"
  add_foreign_key "consultations", "users", column: "patient_id"
  add_foreign_key "consultations", "users", column: "professional_id"
  add_foreign_key "exams", "companies"
  add_foreign_key "exams", "consultations"
  add_foreign_key "exams", "exam_types"
  add_foreign_key "exams", "users", column: "patient_id"
  add_foreign_key "exams", "users", column: "professional_id"
  add_foreign_key "hospitalizations", "beds"
  add_foreign_key "hospitalizations", "companies"
  add_foreign_key "hospitalizations", "users", column: "patient_id"
  add_foreign_key "hospitalizations", "users", column: "professional_id"
  add_foreign_key "medical_records", "companies"
  add_foreign_key "medical_records", "consultations"
  add_foreign_key "medical_records", "users", column: "patient_id"
  add_foreign_key "medical_records", "users", column: "professional_id"
  add_foreign_key "notifications", "users"
  add_foreign_key "prescriptions", "companies"
  add_foreign_key "prescriptions", "consultations"
  add_foreign_key "prescriptions", "users", column: "patient_id"
  add_foreign_key "prescriptions", "users", column: "professional_id"
  add_foreign_key "sessions", "users"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
  add_foreign_key "users", "companies"
  add_foreign_key "users", "roles"
end
