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

ActiveRecord::Schema.define(version: 2022_11_17_213803) do

  create_table "accelo_logs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "model_klass"
    t.string "uuid"
    t.json "result"
    t.index ["uuid"], name: "index_accelo_logs_on_uuid"
  end

  create_table "ad_estimates", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "profitability_estimate_id"
    t.string "publication_type"
    t.integer "ad_type_id"
    t.integer "ad_placement_id"
    t.decimal "value", precision: 8, scale: 2, default: "0.0"
    t.decimal "amount", precision: 8, scale: 2, default: "0.0"
    t.date "start_on"
    t.date "end_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "publication_id"
    t.index ["ad_placement_id"], name: "index_ad_estimates_on_ad_placement_id"
    t.index ["ad_type_id"], name: "index_ad_estimates_on_ad_type_id"
    t.index ["profitability_estimate_id"], name: "index_ad_estimates_on_profitability_estimate_id"
    t.index ["publication_id"], name: "index_ad_estimates_on_publication_id"
  end

  create_table "ad_placements", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.string "ad_value"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at"
    t.string "status", limit: 10, default: "active", null: false
    t.boolean "premium", default: false
    t.string "multi_page_group"
    t.integer "multi_page_index"
    t.string "uuid", null: false
    t.index ["uuid"], name: "index_ad_placements_on_uuid", unique: true
  end

  create_table "ad_placements_page_layouts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "ad_placement_id"
    t.integer "page_layout_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["ad_placement_id", "page_layout_id"], name: "unique_placement_layout", unique: true
    t.index ["ad_placement_id"], name: "index_ad_placements_page_layouts_on_ad_placement_id"
    t.index ["page_layout_id"], name: "index_ad_placements_page_layouts_on_page_layout_id"
  end

  create_table "ad_sponsorships", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "has_users", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", limit: 10, default: "active", null: false
    t.bigint "restricted_ad_type_id"
    t.index ["restricted_ad_type_id"], name: "index_ad_sponsorships_on_restricted_ad_type_id"
  end

  create_table "ad_start_deadline_settings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "business_id"
    t.integer "days_after_deadline"
    t.integer "days_after_holiday_deadline"
    t.integer "cutoff_hour"
    t.integer "cutoff_minute"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_ad_start_deadline_settings_on_business_id"
  end

  create_table "ad_type_publication_types", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "ad_type_id"
    t.integer "publication_type_id"
    t.string "ad_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "minimum_home_count", default: 1, null: false
    t.index ["ad_type_id"], name: "index_ad_type_publication_types_on_ad_type_id"
    t.index ["minimum_home_count", "ad_type_id", "publication_type_id"], name: "index_ad_type_publication_types_on_homes_ad_type_pub_type", unique: true
    t.index ["publication_type_id"], name: "index_ad_type_publication_types_on_publication_type_id"
  end

  create_table "ad_type_split_groups", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "ad_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_type_id"], name: "index_ad_type_split_groups_on_ad_type_id"
  end

  create_table "ad_type_splits", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "ad_type_split_group_id"
    t.integer "ad_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_type_id"], name: "index_ad_type_splits_on_ad_type_id"
    t.index ["ad_type_split_group_id"], name: "index_ad_type_splits_on_ad_type_split_group_id"
  end

  create_table "ad_types", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.string "formula_name"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at"
    t.string "status", limit: 10, default: "active", null: false
    t.boolean "zero_value", default: false, null: false
    t.boolean "charitable", default: false, null: false
    t.boolean "restricted", default: false, null: false
    t.integer "page_span", default: 1
    t.boolean "premium", default: false
    t.string "category", default: "ad"
    t.boolean "advertorial", default: false, null: false
    t.boolean "article_sponsorship", default: false, null: false
    t.decimal "size", precision: 6, scale: 5, null: false
    t.string "uuid", null: false
    t.boolean "no_commission", default: false, null: false
    t.index ["formula_name"], name: "index_ad_types_on_formula_name", unique: true
    t.index ["name"], name: "index_ad_types_on_name", unique: true
    t.index ["uuid"], name: "index_ad_types_on_uuid", unique: true
  end

  create_table "ad_types_page_layouts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "page_layout_id"
    t.integer "ad_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_type_id"], name: "index_ad_types_page_layouts_on_ad_type_id"
    t.index ["page_layout_id"], name: "index_ad_types_page_layouts_on_page_layout_id"
  end

  create_table "adc_ae_commissions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id"
    t.integer "order_item_id"
    t.decimal "amount", precision: 8, scale: 2
    t.decimal "percent", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "commission_report_id"
    t.integer "office_id"
    t.date "on_date"
    t.integer "order_id", null: false
    t.integer "client_id"
    t.integer "contract_order_item_id"
    t.boolean "paid", default: false
    t.boolean "soft_deleted", default: false
    t.integer "business_id"
    t.integer "commission_statement_id"
    t.index ["business_id"], name: "index_adc_ae_commissions_on_business_id"
    t.index ["client_id"], name: "index_adc_ae_commissions_on_client_id"
    t.index ["commission_report_id"], name: "index_adc_ae_commissions_on_commission_report_id"
    t.index ["commission_statement_id"], name: "index_adc_ae_commissions_on_commission_statement_id"
    t.index ["contract_order_item_id"], name: "index_adc_ae_commissions_on_contract_order_item_id"
    t.index ["office_id"], name: "index_adc_ae_commissions_on_office_id"
    t.index ["on_date"], name: "index_adc_ae_commissions_on_on_date"
    t.index ["order_id"], name: "index_adc_ae_commissions_on_order_id"
    t.index ["order_item_id"], name: "index_adc_ae_commissions_on_order_item_id"
    t.index ["user_id"], name: "index_adc_ae_commissions_on_user_id"
  end

  create_table "advisory_board_categories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agencies", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agreement_builder_digital_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "agreement_builder_id"
    t.decimal "price", precision: 8, scale: 2
    t.integer "units"
    t.bigint "ad_type_id"
    t.date "start_on"
    t.bigint "publication_type_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "has_call_tracking_addon", default: false, null: false
    t.bigint "source_item_id"
    t.integer "ad_placement_id"
    t.json "custom_options"
    t.index ["ad_type_id"], name: "index_agreement_builder_digital_items_on_ad_type_id"
    t.index ["agreement_builder_id"], name: "index_agreement_builder_digital_items_on_agreement_builder_id"
    t.index ["publication_type_id"], name: "index_agreement_builder_digital_items_on_publication_type_id"
    t.index ["source_item_id"], name: "fk_rails_b8a77808d5"
  end

  create_table "agreement_builder_events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "agreement_builder_id", null: false
    t.bigint "user_id"
    t.text "description", null: false
    t.text "details"
    t.datetime "time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "event_type", null: false
    t.index ["agreement_builder_id"], name: "index_agreement_builder_events_on_agreement_builder_id"
    t.index ["event_type"], name: "index_agreement_builder_events_on_event_type"
    t.index ["user_id"], name: "index_agreement_builder_events_on_user_id"
  end

  create_table "agreement_builder_print_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "agreement_builder_id"
    t.integer "order_item_type"
    t.bigint "ad_type_id"
    t.bigint "ad_placement_id"
    t.integer "duration"
    t.date "start_on"
    t.bigint "publication_id"
    t.decimal "price", precision: 8, scale: 2
    t.integer "number_of_sponsor_spotlights"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_placement_id"], name: "index_agreement_builder_print_items_on_ad_placement_id"
    t.index ["ad_type_id"], name: "index_agreement_builder_print_items_on_ad_type_id"
    t.index ["agreement_builder_id"], name: "index_agreement_builder_print_items_on_agreement_builder_id"
    t.index ["publication_id"], name: "index_agreement_builder_print_items_on_publication_id"
  end

  create_table "agreement_builder_review_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "agreement_builder_reviewable_type"
    t.bigint "agreement_builder_reviewable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "agreement_builder_ruleable_type"
    t.bigint "agreement_builder_ruleable_id"
    t.datetime "reviewed_at"
    t.bigint "reviewed_by_id"
    t.index ["agreement_builder_reviewable_type", "agreement_builder_reviewable_id"], name: "idx_agreement_builder_reviewable"
  end

  create_table "agreement_builder_rule_article_sponsorships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "ad_sponsorship_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agreement_builder_rule_barters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.decimal "amount", precision: 8, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agreement_builder_rule_hyport_dsses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agreement_builder_rule_hyport_notes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agreement_builder_rule_oversellings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "error_messages"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agreement_builder_rule_payment_methods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "payment_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "emails"
    t.integer "payment_period"
  end

  create_table "agreement_builder_rule_ppad_cross_sales", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "pay_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agreement_builder_rule_sponsor_index_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "index_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agreement_builders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.decimal "setup_fee", precision: 8, scale: 2
    t.decimal "monthly_tradeout", precision: 8, scale: 2
    t.string "tradeout_description"
    t.timestamp "locked_at"
    t.bigint "sales_rep_id"
    t.bigint "created_by_id"
    t.bigint "client_id"
    t.bigint "order_agreement_id"
    t.boolean "extended_reach_opted_out", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "client_name"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "alt_phone"
    t.string "website"
    t.string "address1"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.bigint "initial_contact_id"
    t.datetime "deleted_at"
    t.string "series_uuid"
    t.boolean "initial_client", default: false, null: false
    t.bigint "order_id"
    t.datetime "converted_at"
    t.integer "setup_fee_months", default: 1
    t.text "confirmation_errors"
    t.index ["client_id"], name: "index_agreement_builders_on_client_id"
    t.index ["created_by_id"], name: "index_agreement_builders_on_created_by_id"
    t.index ["initial_contact_id"], name: "index_agreement_builders_on_initial_contact_id"
    t.index ["order_agreement_id"], name: "index_agreement_builders_on_order_agreement_id"
    t.index ["order_id"], name: "index_agreement_builders_on_order_id"
    t.index ["sales_rep_id"], name: "index_agreement_builders_on_sales_rep_id"
  end

  create_table "agreement_infraction_types", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 1, null: false
    t.text "solution"
  end

  create_table "agreement_issues", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "agreement_review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "issuable_type"
    t.integer "issuable_id"
    t.index ["agreement_review_id"], name: "index_agreement_issues_on_agreement_review_id"
    t.index ["issuable_type", "issuable_id"], name: "index_agreement_issues_on_issuable_type_and_issuable_id"
  end

  create_table "agreement_rejection_types", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 1, null: false
    t.text "solution"
  end

  create_table "agreement_review_documents", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "document_id"
    t.integer "agreement_review_id"
    t.index ["agreement_review_id"], name: "index_agreement_review_documents_on_agreement_review_id"
    t.index ["document_id"], name: "index_agreement_review_documents_on_document_id", unique: true
  end

  create_table "agreement_reviews", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "order_agreement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "note"
    t.integer "status", default: 0, null: false
    t.integer "reviewer_id"
    t.datetime "reviewed_at"
    t.boolean "auto_approved", default: false, null: false
    t.index ["order_agreement_id"], name: "index_agreement_reviews_on_order_agreement_id"
    t.index ["reviewer_id"], name: "fk_rails_d6c14ad1a3"
  end

  create_table "approved_page_pdfs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "data_file_size"
    t.string "data_content_type"
    t.string "data_file_name"
    t.string "page_type", null: false
    t.integer "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.string "data"
    t.index ["page_id", "page_type"], name: "index_approved_page_pdfs_on_page_id_and_page_type"
    t.index ["user_id"], name: "index_approved_page_pdfs_on_user_id"
  end

  create_table "auth_net_transactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "auth_net_id"
    t.string "response"
    t.timestamp "submit_time"
    t.integer "payment_number"
    t.integer "attempt_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "transactionable_type"
    t.bigint "transactionable_id"
    t.index ["transactionable_type", "transactionable_id"], name: "index_auth_net_transactions_on_transactionable"
  end

  create_table "authentication_tokens", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id"
    t.integer "resource_id"
    t.string "resource_type"
    t.string "authorized_action"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "business_id"
    t.index ["business_id"], name: "index_authentication_tokens_on_business_id"
    t.index ["resource_id", "resource_type"], name: "index_authentication_tokens_on_resource_id_and_resource_type"
    t.index ["user_id"], name: "index_authentication_tokens_on_user_id"
  end

  create_table "authorized_credit_cards", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "profile_id"
    t.string "payment_profile_id"
    t.string "auth_code"
    t.integer "created_by_id", null: false
    t.integer "user_id", null: false
    t.integer "credit_card_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "card_type"
    t.date "expiration", null: false
    t.string "name"
    t.string "client_info"
    t.integer "business_id"
    t.index ["auth_code"], name: "index_authorized_credit_cards_on_auth_code", unique: true
    t.index ["created_by_id"], name: "index_authorized_credit_cards_on_created_by_id"
    t.index ["credit_card_id"], name: "index_authorized_credit_cards_on_credit_card_id"
    t.index ["profile_id"], name: "index_authorized_credit_cards_on_profile_id"
    t.index ["user_id"], name: "index_authorized_credit_cards_on_user_id"
  end

  create_table "bank_accounts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "client_id", null: false
    t.string "name_on_account", limit: 22, null: false
    t.string "bank_name", limit: 50
    t.integer "payment_profile_id"
    t.boolean "deleted", default: false
    t.boolean "noc"
    t.string "noc_code", limit: 3
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "routing_number", limit: 4
    t.string "account_number", limit: 4
    t.integer "profile_id"
    t.string "account_type", limit: 20, default: "businessChecking", null: false
    t.boolean "validated"
    t.index ["client_id"], name: "index_bank_accounts_on_client_id"
  end

  create_table "business_commission_components", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "business_id"
    t.integer "commission_component_id"
    t.date "start_on"
    t.date "end_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_business_commission_components_on_business_id"
    t.index ["commission_component_id"], name: "index_business_commission_components_on_commission_component_id"
  end

  create_table "business_commission_issues", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "business_id"
    t.integer "commission_issue_id"
    t.date "start_on"
    t.date "end_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_business_commission_issues_on_business_id"
    t.index ["commission_issue_id"], name: "index_business_commission_issues_on_commission_issue_id"
  end

  create_table "business_contact_tag_eligibilities", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "business_id", null: false
    t.integer "contact_tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id", "contact_tag_id"], name: "index_business_contact_tag_eligibility_uniqueness", unique: true
    t.index ["business_id"], name: "index_business_contact_tag_eligibilities_on_business_id"
    t.index ["contact_tag_id"], name: "index_business_contact_tag_eligibilities_on_contact_tag_id"
  end

  create_table "business_publication_types", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "business_id"
    t.integer "publication_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_business_publication_types_on_business_id"
    t.index ["publication_type_id"], name: "index_business_publication_types_on_publication_type_id"
  end

  create_table "businesses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "display"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.text "invoice_farewell_message"
    t.integer "default_publication_type_id"
    t.string "auth_net_config_key"
    t.string "pdf_logo"
    t.string "logo"
    t.json "feature_configuration"
    t.string "domain", default: "n2pub.com"
    t.string "parent_business"
    t.string "abbreviation", limit: 5
    t.boolean "active", default: true, null: false
    t.text "n2_company_invoice_farewell_message"
  end

  create_table "cash_receiveds", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.date "on_date"
    t.integer "user_id"
    t.integer "client_id"
    t.integer "commission_report_id"
    t.decimal "amount", precision: 8, scale: 2
    t.integer "invoice_item_receipt_id"
    t.string "kind", limit: 20
    t.integer "invoice_item_receipt_refund_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "commission_type"
    t.integer "office_id"
    t.string "classification"
    t.string "destination"
    t.decimal "percentage_split", precision: 5, scale: 3, default: "1.0"
    t.date "contract_on"
    t.integer "order_item_id"
    t.integer "sales_rep_id"
    t.boolean "cross_sold", default: false
    t.integer "pay_info_id"
    t.integer "statement_id"
    t.string "statement_type"
    t.index ["client_id"], name: "fk_cash_receiveds_clients"
    t.index ["commission_report_id"], name: "fk_cash_receiveds_commission_reports"
    t.index ["invoice_item_receipt_id"], name: "fk_cash_receiveds_o2_invoice_item_receipts"
    t.index ["invoice_item_receipt_refund_id"], name: "fk_cash_receiveds_o2_invoice_item_receipt_refunds"
    t.index ["office_id"], name: "index_cash_receiveds_on_office_id"
    t.index ["on_date"], name: "index_cash_receiveds_on_on_date"
    t.index ["order_item_id"], name: "index_cash_receiveds_on_order_item_id"
    t.index ["pay_info_id"], name: "index_cash_receiveds_on_pay_info_id"
    t.index ["sales_rep_id"], name: "index_cash_receiveds_on_sales_rep_id"
    t.index ["statement_id", "statement_type"], name: "index_cash_receiveds_on_statement_id_and_statement_type"
    t.index ["statement_id"], name: "index_cash_receiveds_on_statement_id"
    t.index ["user_id"], name: "index_cash_receiveds_on_user_id"
  end

  create_table "check_batches", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "created_by", null: false
    t.datetime "closed_at"
    t.integer "closed_by"
    t.integer "business_id"
    t.index ["closed_by"], name: "fk_check_batches_closed"
    t.index ["created_by"], name: "fk_check_batches_created"
  end

  create_table "client_categories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.integer "business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "client_event_details", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "description", null: false
    t.integer "publication_id"
    t.integer "client_event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_event_id"], name: "index_client_event_details_on_client_event_id"
    t.index ["publication_id"], name: "index_client_event_details_on_publication_id"
  end

  create_table "client_event_publications", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "client_event_id"
    t.integer "publication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_event_id"], name: "index_client_event_publications_on_client_event_id"
    t.index ["publication_id"], name: "index_client_event_publications_on_publication_id"
  end

  create_table "client_event_roles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "client_event_id"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_event_id"], name: "index_client_event_roles_on_client_event_id"
    t.index ["role_id"], name: "index_client_event_roles_on_role_id"
  end

  create_table "client_events", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "description", null: false
    t.integer "client_id"
    t.datetime "time"
    t.integer "user_id"
    t.boolean "include_byline", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "event_type", default: "legacy_admin_event"
    t.boolean "stripe_event", default: false
    t.index ["client_id"], name: "index_client_events_on_client_id"
    t.index ["event_type"], name: "index_client_events_on_event_type"
    t.index ["user_id"], name: "index_client_events_on_user_id"
  end

  create_table "client_rep_assignments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "client_id", null: false
    t.integer "user_id", null: false
    t.date "start_on"
    t.date "end_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "product_line_id"
    t.index ["client_id"], name: "fk_client_rep_assignments_c"
    t.index ["product_line_id"], name: "index_client_rep_assignments_on_product_line_id"
    t.index ["user_id"], name: "fk_client_rep_assignments_u"
  end

  create_table "client_tokens", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "client_id"
    t.integer "resource_id"
    t.string "resource_type"
    t.string "authorized_action"
    t.string "token"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "mercury_uuid", limit: 36
    t.index ["client_id"], name: "index_client_tokens_on_client_id"
    t.index ["resource_id", "resource_type"], name: "index_client_tokens_on_resource_id_and_resource_type"
  end

  create_table "client_transfers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "client_id"
    t.integer "requester_id"
    t.integer "transfer_to_id"
    t.string "state", default: "open"
    t.string "mercury_uuid", limit: 36
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date "accepted_on"
    t.integer "client_rep_assignment_id"
    t.integer "accepted_by_id"
    t.integer "product_line_id"
    t.index ["client_id"], name: "index_client_transfers_on_client_id"
    t.index ["client_rep_assignment_id"], name: "index_client_transfers_on_client_rep_assignment_id"
    t.index ["requester_id"], name: "index_client_transfers_on_requester_id"
    t.index ["transfer_to_id"], name: "index_client_transfers_on_transfer_to_id"
  end

  create_table "clients", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.integer "user_id"
    t.string "status", limit: 10, default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at"
    t.integer "cim_profile_id"
    t.integer "office_id"
    t.string "dba"
    t.datetime "deleted_at"
    t.string "url"
    t.boolean "dba_on_invoice", default: true, null: false
    t.boolean "email_paid_invoices", default: true, null: false
    t.string "ein", limit: 10
    t.boolean "show_url_in_sponsor_index", default: true, null: false
    t.integer "merged_into_client_id"
    t.integer "selling_rep_id"
    t.boolean "manager_locked", default: false
    t.boolean "delinquent", default: false
    t.string "uuid", limit: 36, null: false
    t.boolean "override_run_by_default", default: false
    t.string "auth_net_config_key"
    t.boolean "auto_renew_orders_if_enabled", default: false, null: false
    t.string "logo"
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.integer "logo_file_size"
    t.integer "agency_id"
    t.integer "client_category_id"
    t.bigint "business_id"
    t.string "source_token"
    t.boolean "using_stripe", default: true
    t.date "last_manual_charge_on"
    t.index ["agency_id"], name: "fk_rails_987104bb65"
    t.index ["business_id"], name: "index_clients_on_business_id"
    t.index ["client_category_id"], name: "index_clients_on_client_category_id"
    t.index ["merged_into_client_id"], name: "index_clients_on_merged_into_client_id"
    t.index ["office_id"], name: "index_clients_on_office_id"
    t.index ["selling_rep_id"], name: "index_clients_on_selling_rep_id"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "commission_components", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "class_name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "publication_type_id"
    t.string "statement_type", default: "franchise_statement", null: false
    t.string "display"
    t.text "role_levels"
    t.integer "display_position"
    t.boolean "always_show", default: false
    t.string "presenter_override"
    t.string "summary_field"
    t.index ["publication_type_id"], name: "index_commission_components_on_publication_type_id"
  end

  create_table "commission_issues", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "class_name"
    t.integer "publication_type_id"
    t.string "statement_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "display"
    t.index ["publication_type_id"], name: "index_commission_issues_on_publication_type_id"
  end

  create_table "commission_item_templates", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "category"
    t.string "name"
    t.boolean "credit", default: false
    t.decimal "default_price", precision: 8, scale: 2
    t.boolean "editable_price", default: false
    t.boolean "quantity_required", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "editable_description", default: false
    t.integer "position"
  end

  create_table "commission_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_commission_report_id"
    t.text "description"
    t.decimal "price", precision: 8, scale: 2
    t.integer "count"
    t.decimal "total", precision: 8, scale: 2
    t.boolean "credit", default: false
    t.string "category"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "commission_item_template_id"
    t.integer "updated_by_id"
    t.integer "created_by_id"
    t.index ["commission_item_template_id"], name: "index_commission_items_on_commission_item_template_id"
    t.index ["created_by_id"], name: "index_commission_items_on_created_by_id"
    t.index ["updated_by_id"], name: "index_commission_items_on_updated_by_id"
    t.index ["user_commission_report_id"], name: "UCR_ID"
  end

  create_table "commission_misc_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.boolean "credit", default: false
    t.decimal "amount", precision: 8, scale: 2, default: "0.0"
    t.integer "quantity", default: 1
    t.text "notes"
    t.datetime "finalized_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "statement_id"
    t.string "statement_type"
    t.integer "updated_by_id"
    t.index ["statement_type", "statement_id"], name: "index_commission_misc_items_on_statement_type_and_statement_id"
    t.index ["updated_by_id"], name: "index_commission_misc_items_on_updated_by_id"
  end

  create_table "commission_production_fees", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "fee_type"
    t.integer "count"
    t.decimal "amount", precision: 10
    t.datetime "finalized_at"
    t.bigint "commission_cost_id"
    t.integer "production_fee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "override", default: false
    t.boolean "waived", default: false
    t.string "commission_cost_type"
    t.index ["commission_cost_id"], name: "index_commission_production_fees_on_commission_cost_id"
    t.index ["commission_cost_type", "commission_cost_id"], name: "index_commission_production_fees_on_commission_cost"
    t.index ["production_fee_id"], name: "index_commission_production_fees_on_production_fee_id"
  end

  create_table "commission_pub_costs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "commission_report_id"
    t.integer "pages"
    t.integer "subscribers"
    t.boolean "color", default: false, null: false
    t.decimal "cost", precision: 8, scale: 2
    t.decimal "override_cost", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "publication_id"
    t.integer "franchise_statement_id"
    t.boolean "override_pcs", default: false
    t.index ["commission_report_id", "publication_id"], name: "index_commission_pub_costs_uniqueness", unique: true
    t.index ["commission_report_id"], name: "index_commission_pub_costs_on_commission_report_id"
    t.index ["franchise_statement_id"], name: "index_commission_pub_costs_on_franchise_statement_id"
    t.index ["publication_id"], name: "index_commission_pub_costs_on_publication_id"
  end

  create_table "commission_report_blocks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "office_id"
    t.integer "allowed_user_id", null: false
    t.date "block_begins_on"
    t.date "block_ends_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["allowed_user_id"], name: "index_commission_report_blocks_on_allowed_user_id"
    t.index ["office_id"], name: "index_commission_report_blocks_on_office_id"
  end

  create_table "commission_report_chargebacks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "commission_report_id", null: false
    t.integer "client_id", null: false
    t.decimal "amount", precision: 8, scale: 2, null: false
    t.boolean "is_reversal", default: false, null: false
    t.string "note"
    t.index ["client_id"], name: "fk_commission_report_chargebacks_c"
    t.index ["commission_report_id"], name: "fk_commission_report_chargebacks_cr"
  end

  create_table "commission_report_details", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "commission_report_id", null: false
    t.integer "commission_report_item_id", null: false
    t.integer "units"
    t.decimal "amount", precision: 8, scale: 2, null: false
    t.string "note"
    t.index ["commission_report_id"], name: "fk_commission_report_details_cr"
    t.index ["commission_report_item_id"], name: "fk_commission_report_details_cri"
  end

  create_table "commission_report_directories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "commission_report_id", null: false
    t.integer "directory_id", null: false
    t.decimal "ad_value", precision: 8, scale: 2, null: false
    t.index ["commission_report_id"], name: "fk_commission_report_directories_cr"
    t.index ["directory_id"], name: "index_commission_report_directories_on_directory_id", unique: true
  end

  create_table "commission_report_groups", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", null: false
    t.integer "position", limit: 1, null: false
    t.boolean "ad_manager_late_charges", default: false, null: false
    t.index ["name"], name: "index_commission_report_groups_on_name", unique: true
  end

  create_table "commission_report_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "commission_report_group_id", null: false
    t.integer "position", limit: 1, null: false
    t.string "name", null: false
    t.boolean "credit", default: false, null: false
    t.boolean "per_unit_cost", null: false
    t.decimal "default_cost", precision: 8, scale: 2, default: "0.0", null: false
    t.boolean "is_cost_editable", null: false
    t.string "status", limit: 10, default: "active", null: false
    t.boolean "ad_manager_late_charge_revision", default: false, null: false
    t.boolean "ad_manager_late_charge_provided", default: false, null: false
    t.index ["commission_report_group_id"], name: "fk_commission_report_items_g"
    t.index ["name"], name: "index_commission_report_items_on_name", unique: true
  end

  create_table "commission_report_misc_details", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "commission_report_id", null: false
    t.integer "position", limit: 1, null: false
    t.string "name", null: false
    t.boolean "credit", default: false, null: false
    t.decimal "amount", precision: 8, scale: 2, null: false
    t.string "note"
    t.index ["commission_report_id"], name: "fk_commission_report_misc_details_cr"
  end

  create_table "commission_report_override_commissions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "commission_report_id", null: false
    t.integer "user_id", null: false
    t.integer "office_id", null: false
    t.decimal "percentage", precision: 8, scale: 2, default: "0.0", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "paid_on_commission_report_id", null: false
    t.decimal "cash_received", precision: 8, scale: 2, null: false
    t.string "type"
    t.index ["commission_report_id"], name: "commission_report_oc_on_commission_report_id"
    t.index ["office_id"], name: "commission_report_oc_on_commission_office_id"
    t.index ["paid_on_commission_report_id"], name: "commission_report_oc_on_paid_on_commission_report_id"
    t.index ["type"], name: "commission_report_oc_on_type"
    t.index ["user_id"], name: "commission_report_oc_on_commission_user_id"
  end

  create_table "commission_report_publication_costs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "commission_report_id", null: false
    t.integer "newsletter_pages"
    t.integer "newsletter_subscribers"
    t.boolean "newsletter_color", default: false, null: false
    t.decimal "newsletter_cost", precision: 8, scale: 2, null: false
    t.integer "directory_pages"
    t.integer "directory_subscribers"
    t.decimal "directory_shipping", precision: 8, scale: 2, null: false
    t.decimal "directory_cost", precision: 8, scale: 2, null: false
    t.boolean "directory_color", default: false, null: false
    t.boolean "directory_like_newsletter", default: true, null: false
    t.decimal "manual_newsletter_cost", precision: 8, scale: 2
    t.decimal "manual_directory_cost", precision: 8, scale: 2
    t.integer "publication_id", null: false
    t.index ["commission_report_id"], name: "fk_commission_report_publication_costs_cr"
    t.index ["publication_id"], name: "index_commission_report_publication_costs_on_publication_id"
  end

  create_table "commission_reports", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "office_id", null: false
    t.integer "month", null: false
    t.integer "year", null: false
    t.integer "pay_period", null: false
    t.decimal "cash_received", precision: 8, scale: 2
    t.decimal "newsletter_ad_value", precision: 8, scale: 2
    t.decimal "ad_value_percentage", precision: 5, scale: 3
    t.decimal "total", precision: 8, scale: 2
    t.date "finalized_on"
    t.date "paid_on"
    t.decimal "territory_fee", precision: 8, scale: 2
    t.date "pay_period_ends_on"
    t.string "office_type", default: "Office"
    t.index ["office_id", "office_type"], name: "index_commission_reports_on_office_id_and_office_type"
    t.index ["office_id"], name: "fk_commission_reports_o"
  end

  create_table "commission_statement_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "commission_statement_id"
    t.integer "commission_component_id"
    t.decimal "gross", precision: 8, scale: 2, default: "0.0"
    t.decimal "net", precision: 8, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commission_component_id"], name: "index_commission_statement_items_on_commission_component_id"
    t.index ["commission_statement_id"], name: "index_commission_statement_items_on_commission_statement_id"
  end

  create_table "commission_statement_skipped_publications", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "publication_id"
    t.integer "commission_statement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commission_statement_id"], name: "index_statement_skipped_pubs_on_statement_id"
    t.index ["publication_id"], name: "index_statement_skipped_pubs_on_publication_id"
  end

  create_table "commission_statement_transitions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "status"
    t.string "comment"
    t.string "reason"
    t.integer "last_status_id"
    t.integer "transitioned_by_id"
    t.integer "commission_statement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commission_statement_id"], name: "index_statement_transitions_on_statement_id"
    t.index ["last_status_id"], name: "index_commission_statement_transitions_on_last_status_id"
    t.index ["transitioned_by_id"], name: "index_commission_statement_transitions_on_transitioned_by_id"
  end

  create_table "commission_statements", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "entity_id"
    t.date "start_on"
    t.date "end_on"
    t.decimal "net", precision: 12, scale: 2
    t.decimal "gross", precision: 12, scale: 2
    t.date "finalized_at"
    t.date "paid_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "business_id"
    t.index ["business_id"], name: "index_commission_statements_on_business_id"
    t.index ["entity_id", "business_id", "start_on"], name: "index_commission_statements_on_entity_and_business_and_start_on", unique: true
    t.index ["entity_id"], name: "index_commission_statements_on_entity_id"
  end

  create_table "commission_values", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "finalized_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "statement_id"
    t.string "statement_type"
    t.text "values"
    t.integer "commission_component_id"
    t.string "role"
    t.index ["commission_component_id"], name: "index_commission_values_on_commission_component_id"
    t.index ["statement_type", "statement_id"], name: "index_commission_values_on_statement_type_and_statement_id"
  end

  create_table "contact_taggings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "contact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "contact_tag_id", null: false
    t.index ["contact_id", "contact_tag_id"], name: "index_contact_taggings_uniqueness", unique: true
    t.index ["contact_id"], name: "index_contact_taggings_on_contact_id"
    t.index ["contact_tag_id"], name: "fk_rails_9b00b63952"
  end

  create_table "contact_tags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "internal_name", null: false
    t.string "name", null: false
    t.text "description"
    t.boolean "required_for_all_businesses", default: false, null: false
    t.integer "minimum_per_client"
    t.integer "maximum_per_client"
    t.boolean "contact_requires_name", default: false, null: false
    t.boolean "contact_requires_address", default: false, null: false
    t.boolean "contact_requires_email", default: false, null: false
    t.boolean "contact_requires_phone", default: false, null: false
    t.boolean "contact_appears_as_primary_contact_for_client", default: false, null: false
    t.boolean "contact_handles_billing_for_client", default: false, null: false
    t.boolean "contact_receives_expiring_card_notifications", default: false, null: false
    t.boolean "contact_receives_invoice_notifications", default: false, null: false
    t.boolean "contact_appears_in_sponsor_indexes", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "contact_provides_advertorial_details_for_client", default: false, null: false
    t.index ["internal_name"], name: "index_contact_tags_on_internal_name", unique: true
  end

  create_table "contacts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone", limit: 15
    t.string "extension"
    t.string "email"
    t.string "address1", limit: 70
    t.string "city", limit: 50
    t.string "state", limit: 50
    t.string "zip", limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "show_address_in_sponsor_index", default: false, null: false
    t.boolean "show_name_in_sponsor_index", default: false, null: false
    t.string "alt_phone"
    t.string "alt_phone_extension"
    t.string "phone_label"
    t.string "alt_phone_label"
    t.boolean "mobile_index", default: false, null: false
    t.string "address2", limit: 70
    t.string "country", limit: 2, default: "US"
    t.integer "user_id"
    t.string "contactable_type", null: false
    t.integer "contactable_id", null: false
    t.integer "master_contact_id"
    t.string "uuid", limit: 36
    t.string "title"
    t.index ["contactable_type", "contactable_id"], name: "index_contacts_on_contactable_type_and_contactable_id"
    t.index ["master_contact_id"], name: "fk_rails_6f940a0485"
    t.index ["user_id"], name: "index_contacts_on_user_id"
    t.index ["uuid"], name: "index_contacts_on_uuid", unique: true
  end

  create_table "convert_error_invoice_receipts", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "invoice_receipt_id"
    t.decimal "amount", precision: 10
    t.decimal "converted_amount", precision: 10
  end

  create_table "convert_error_unverified_invoice_receipts", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "invoice_receipt_id"
    t.decimal "amount", precision: 10
    t.decimal "converted_amount", precision: 10
  end

  create_table "credit_cards", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "client_id", null: false
    t.string "card_type", limit: 30
    t.string "name", limit: 100
    t.string "number"
    t.date "expiration"
    t.datetime "created_at", null: false
    t.datetime "updated_at"
    t.integer "profile_id"
    t.integer "payment_profile_id"
    t.string "address1", limit: 70
    t.string "city", limit: 50
    t.string "state", limit: 50
    t.string "zip", limit: 20
    t.boolean "allow_no_name", default: false, null: false
    t.boolean "allow_no_address", default: false, null: false
    t.boolean "deleted", default: false, null: false
    t.boolean "validated"
    t.string "address2", limit: 70
    t.string "country", limit: 2, default: "US"
    t.boolean "anonymous", default: false
    t.index ["client_id"], name: "index_credit_cards_on_client_id"
  end

  create_table "cron_stripe_jobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "job_name"
    t.date "job_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_name", "job_date"], name: "index_cron_stripe_jobs_on_job_name_and_job_date", unique: true
  end

  create_table "digital_fees", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "on_date", null: false
    t.decimal "amount", precision: 8, scale: 2
    t.integer "user_id"
    t.integer "sales_rep_id"
    t.string "commission_type"
    t.boolean "cross_sold", default: false
    t.decimal "percentage_split", precision: 5, scale: 3, default: "1.0"
    t.string "destination"
    t.integer "client_id"
    t.integer "office_id"
    t.integer "order_item_id"
    t.integer "pay_info_id"
    t.integer "ad_publication_id"
    t.integer "statement_id"
    t.string "statement_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_publication_id"], name: "index_digital_fees_on_ad_publication_id"
    t.index ["client_id"], name: "index_digital_fees_on_client_id"
    t.index ["office_id"], name: "index_digital_fees_on_office_id"
    t.index ["order_item_id"], name: "index_digital_fees_on_order_item_id"
    t.index ["pay_info_id"], name: "index_digital_fees_on_pay_info_id"
    t.index ["sales_rep_id"], name: "index_digital_fees_on_sales_rep_id"
    t.index ["statement_id", "statement_type"], name: "index_digital_fees_on_statement_id_and_statement_type"
    t.index ["statement_id"], name: "index_digital_fees_on_statement_id"
    t.index ["user_id"], name: "index_digital_fees_on_user_id"
  end

  create_table "directories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "year", null: false
    t.date "finalized_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "custom_header"
    t.string "lot_format", limit: 10, default: "1", null: false
    t.integer "publication_id"
    t.index ["publication_id", "year"], name: "index_directories_on_publication_id_and_year"
  end

  create_table "directory_children", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "directory_listing_id"
    t.string "name"
    t.string "age"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["directory_listing_id"], name: "directory_children_directory_listing_id_fkey"
  end

  create_table "directory_costs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.decimal "design", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "print", precision: 8, scale: 2, default: "0.0", null: false
    t.integer "print_page_limit", null: false
    t.decimal "print_extra_sheet", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "shipping_estimate", precision: 8, scale: 2, default: "0.0", null: false
  end

  create_table "directory_listing_children", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "directory_listing_id", null: false
    t.integer "position", limit: 1, null: false
    t.string "name", null: false
    t.string "age"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["directory_listing_id"], name: "directory_listing_children_directory_listing_id_fkey"
  end

  create_table "directory_listing_lots", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "directory_id", null: false
    t.integer "directory_listing_id", null: false
    t.string "full_text"
    t.integer "sort_order"
    t.string "json_parts"
    t.string "lot_format"
    t.index ["directory_id"], name: "directory_listing_lots_directory_id_fkey"
    t.index ["directory_listing_id"], name: "directory_listing_lots_directory_listing_id_fkey"
  end

  create_table "directory_listing_uploads", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "directory_id", null: false
    t.integer "data_file_size"
    t.string "data_content_type"
    t.string "data_file_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "data"
    t.index ["directory_id"], name: "directory_listing_uploads_directory_id_fkey"
  end

  create_table "directory_listings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "directory_id"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "spouse_first_name"
    t.string "spouse_last_name"
    t.string "home_phone"
    t.string "office_phone"
    t.string "cell_phone"
    t.string "pets"
    t.string "lot", limit: 30
    t.string "email"
    t.string "alternate_email"
    t.string "occupation"
    t.string "vacation_home_address", limit: 60
    t.string "vacation_home_city", limit: 50
    t.string "vacation_home_state", limit: 50
    t.string "vacation_home_zip", limit: 20
    t.string "vacation_home_phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "emergency_contact_name"
    t.string "emergency_contact_phone"
    t.string "spouse_cell_phone"
    t.string "spouse_occupation"
    t.string "house_number", null: false
    t.string "street_name", null: false
    t.string "upper_street_name"
    t.string "custom_value"
    t.string "vacation_home_address2", limit: 60
    t.string "vacation_home_country", limit: 2
    t.index ["directory_id"], name: "directory_listings_directory_id_fkey"
  end

  create_table "discounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.decimal "amount", precision: 8, scale: 2, default: "0.0", null: false
    t.integer "units", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_discounts_on_order_id"
  end

  create_table "documents", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", null: false
    t.string "data_file_name"
    t.string "data_content_type"
    t.integer "data_file_size"
    t.text "reason_for_rejection"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "data"
    t.integer "pages"
    t.integer "uploaded_by_id"
    t.string "documentable_type", null: false
    t.integer "documentable_id", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_documents_on_deleted_at"
    t.index ["documentable_type", "documentable_id"], name: "index_documents_on_documentable_type_and_documentable_id"
  end

  create_table "early_terminations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "due_on"
    t.decimal "amount", precision: 12, scale: 2
    t.decimal "past_due", precision: 12, scale: 2
    t.datetime "sent_at"
    t.string "sent_by"
    t.text "sent_to"
    t.integer "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "emailed"
  end

  create_table "editions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "publication_id", null: false
    t.date "published_on", null: false
    t.date "deadline_date"
    t.date "effective_deadline"
    t.string "uuid", null: false
    t.integer "office_id", null: false
    t.integer "entity_id", null: false
    t.integer "area_director_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "edition_date"
    t.boolean "inbound_leads_program", default: false, null: false
    t.index ["area_director_id"], name: "index_editions_on_area_director_id"
    t.index ["deadline_date"], name: "index_editions_on_deadline_date"
    t.index ["edition_date"], name: "index_editions_on_edition_date"
    t.index ["entity_id"], name: "index_editions_on_entity_id"
    t.index ["inbound_leads_program"], name: "index_editions_on_inbound_leads_program"
    t.index ["office_id"], name: "index_editions_on_office_id"
    t.index ["publication_id", "edition_date"], name: "index_editions_on_publication_id_and_edition_date", unique: true
    t.index ["publication_id"], name: "index_editions_on_publication_id"
    t.index ["uuid"], name: "index_editions_on_uuid"
  end

  create_table "effective_order_item_cache", primary_key: "order_item_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "client_id", null: false
    t.integer "office_id", null: false
    t.integer "business_id", null: false
    t.integer "last_agreement_review_id"
    t.integer "publication_id"
    t.integer "ad_type_id"
    t.string "ad_modifier_type"
    t.integer "ad_modifier_id"
    t.integer "ad_key_order", null: false
    t.integer "ad_key_publication"
    t.string "ad_key_category", null: false
    t.date "start_on", null: false
    t.date "end_on"
    t.integer "duration", null: false
    t.string "publication_type"
    t.integer "office_deadline_day", null: false
    t.string "client_name"
    t.string "office_name"
    t.string "publication_name"
    t.string "ad_type_name"
    t.string "ad_modifier_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "order_kind", null: false
    t.datetime "order_created_at", null: false
    t.date "first_invoice_due_on"
    t.date "first_deadline_date", null: false
    t.integer "office_deadline_distance", null: false
    t.datetime "confirmed_at", null: false
    t.string "ad_key_order_gid"
    t.index ["ad_key_category"], name: "index_effective_order_item_cache_on_ad_key_category"
    t.index ["ad_key_order"], name: "index_effective_order_item_cache_on_ad_key_order"
    t.index ["ad_key_order_gid"], name: "index_effective_order_item_cache_on_ad_key_order_gid"
    t.index ["ad_key_publication"], name: "index_effective_order_item_cache_on_ad_key_publication"
    t.index ["ad_modifier_type", "ad_modifier_id"], name: "index_effective_order_item_cache_on_ad_modifier"
    t.index ["ad_type_id"], name: "index_effective_order_item_cache_on_ad_type_id"
    t.index ["business_id"], name: "index_effective_order_item_cache_on_business_id"
    t.index ["client_id"], name: "index_effective_order_item_cache_on_client_id"
    t.index ["confirmed_at"], name: "index_effective_order_item_cache_on_confirmed_at"
    t.index ["duration"], name: "index_effective_order_item_cache_on_duration"
    t.index ["end_on"], name: "index_effective_order_item_cache_on_end_on"
    t.index ["first_deadline_date"], name: "index_effective_order_item_cache_on_first_deadline_date"
    t.index ["last_agreement_review_id"], name: "index_effective_order_item_cache_on_last_agreement_review_id"
    t.index ["office_deadline_day"], name: "index_effective_order_item_cache_on_office_deadline_day"
    t.index ["office_id"], name: "index_effective_order_item_cache_on_office_id"
    t.index ["order_id"], name: "index_effective_order_item_cache_on_order_id"
    t.index ["publication_id"], name: "index_effective_order_item_cache_on_publication_id"
    t.index ["publication_type"], name: "index_effective_order_item_cache_on_publication_type"
    t.index ["start_on"], name: "index_effective_order_item_cache_on_start_on"
  end

  create_table "email_logs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "referred_type"
    t.integer "referred_id"
    t.integer "user_id"
    t.string "to_name", null: false
    t.string "to_email", null: false
    t.string "subject"
    t.text "message"
    t.datetime "created_at", null: false
    t.index ["referred_type", "referred_id"], name: "index_email_logs_on_referred_type_and_referred_id", length: { referred_type: 8 }
    t.index ["user_id"], name: "fk_email_logs_users"
  end

  create_table "emails", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "handle"
    t.string "to_name", null: false
    t.string "to_email", null: false
    t.string "subject", null: false
    t.text "message", null: false
  end

  create_table "entities", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "w9_status", default: 0, null: false
    t.integer "voided_check_status", default: 0, null: false
    t.string "identifier"
    t.integer "afs_rep_id"
    t.date "franchisee_signed_on"
    t.boolean "admin_notified_paperwork_needed", default: false, null: false
    t.string "paylocity_id"
    t.string "uuid"
    t.boolean "n2_managed", default: false, null: false
    t.index ["afs_rep_id"], name: "index_entities_on_afs_rep_id"
    t.index ["name"], name: "index_entities_on_name", unique: true
    t.index ["paylocity_id"], name: "index_entities_on_paylocity_id"
  end

  create_table "expected_cash_receiveds", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "client_id"
    t.integer "commission_report_id"
    t.bigint "invoice_item_id"
    t.integer "office_id"
    t.integer "order_item_id"
    t.integer "sales_rep_id"
    t.integer "pay_info_id"
    t.integer "statement_id"
    t.boolean "cross_sold", default: false
    t.date "on_date"
    t.date "contract_on"
    t.string "kind", limit: 20
    t.string "commission_type"
    t.string "classification"
    t.string "destination"
    t.string "statement_type"
    t.decimal "amount", precision: 8, scale: 2
    t.decimal "percentage_split", precision: 5, scale: 3, default: "1.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invoice_item_type"
    t.index ["client_id"], name: "index_expected_cash_receiveds_on_client_id"
    t.index ["commission_report_id"], name: "index_expected_cash_receiveds_on_commission_report_id"
    t.index ["invoice_item_id"], name: "index_expected_cash_receiveds_on_invoice_item_id"
    t.index ["invoice_item_type", "invoice_item_id"], name: "index_invoice_item_on_expected_cash_receiveds"
    t.index ["office_id"], name: "index_expected_cash_receiveds_on_office_id"
    t.index ["order_item_id"], name: "index_expected_cash_receiveds_on_order_item_id"
    t.index ["pay_info_id"], name: "index_expected_cash_receiveds_on_pay_info_id"
    t.index ["sales_rep_id"], name: "index_expected_cash_receiveds_on_sales_rep_id"
    t.index ["statement_id", "statement_type"], name: "index_expected_cash_receiveds_on_statement_id_and_statement_type"
    t.index ["statement_id"], name: "index_expected_cash_receiveds_on_statement_id"
    t.index ["user_id"], name: "index_expected_cash_receiveds_on_user_id"
  end

  create_table "extra_copies_cost_sheets", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "office_id"
    t.integer "commission_statement_id"
    t.integer "area_director_id"
    t.date "approval_date"
    t.date "finalized_at"
    t.integer "copies"
    t.decimal "amount", precision: 10, scale: 2, default: "0.0"
    t.decimal "shipping", precision: 10, scale: 2, default: "0.0"
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_director_id"], name: "index_extra_copies_cost_sheets_on_area_director_id"
    t.index ["commission_statement_id"], name: "index_extra_copies_cost_sheets_on_commission_statement_id"
    t.index ["office_id"], name: "index_extra_copies_cost_sheets_on_office_id"
    t.index ["user_id"], name: "index_extra_copies_cost_sheets_on_user_id"
    t.index ["uuid"], name: "index_extra_copies_cost_sheets_on_uuid"
  end

  create_table "extra_copy_fees", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "extra_copies_cost_sheet_id"
    t.integer "publication_id"
    t.date "publish_on"
    t.integer "copies"
    t.decimal "amount", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["extra_copies_cost_sheet_id", "publication_id", "publish_on"], name: "extra_copy_fees_by_publication", unique: true
    t.index ["extra_copies_cost_sheet_id"], name: "index_extra_copy_fees_on_extra_copies_cost_sheet_id"
    t.index ["publication_id"], name: "index_extra_copy_fees_on_publication_id"
  end

  create_table "failed_payment_email_logs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.integer "attempts_made", default: 0, null: false
    t.date "last_sent_on"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_failed_payment_email_logs_on_client_id"
  end

  create_table "font_metrics", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "font", limit: 30, null: false
    t.string "word", null: false
    t.decimal "width", precision: 8, scale: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["font", "word"], name: "index_font_metrics_on_font_and_word"
  end

  create_table "franchise_profit_milestones", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "milestone_id"
    t.integer "franchise_profit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["franchise_profit_id"], name: "index_franchise_profit_milestones_on_franchise_profit_id"
    t.index ["milestone_id"], name: "index_franchise_profit_milestones_on_milestone_id"
  end

  create_table "franchise_profits", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "commission_on"
    t.decimal "ad_management_cash", precision: 8, scale: 2, default: "0.0"
    t.decimal "ad_management_rebate", precision: 8, scale: 2, default: "0.0"
    t.decimal "ad_value", precision: 8, scale: 2, default: "0.0"
    t.decimal "entity_misc", precision: 8, scale: 2, default: "0.0"
    t.decimal "franchise_misc", precision: 8, scale: 2, default: "0.0"
    t.decimal "incoming_cash_received", precision: 8, scale: 2, default: "0.0"
    t.decimal "outgoing_cash_received", precision: 8, scale: 2, default: "0.0"
    t.decimal "pending_debit_credits", precision: 8, scale: 2, default: "0.0"
    t.decimal "profit", precision: 8, scale: 2, default: "0.0"
    t.decimal "publication_cost", precision: 8, scale: 2, default: "0.0"
    t.decimal "standard_cash_received", precision: 8, scale: 2, default: "0.0"
    t.decimal "upfront_commission", precision: 8, scale: 2, default: "0.0"
    t.integer "commission_statement_id"
    t.integer "franchise_statement_id"
    t.string "development_director_uuid"
    t.string "entity_uuid"
    t.string "publication_uuid"
    t.string "region_director_uuid"
    t.string "sales_director_uuid"
    t.string "user_uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.string "business_uuid"
    t.integer "user_commission_report_id"
    t.date "publish_on"
    t.decimal "incoming_and_standard_digital_fees", precision: 8, scale: 2, default: "0.0"
    t.decimal "outgoing_digital_fees", precision: 8, scale: 2, default: "0.0"
    t.decimal "digital_management_rebate", precision: 8, scale: 2, default: "0.0"
    t.decimal "inbound_leads_program_fees", precision: 8, scale: 2, default: "0.0"
    t.decimal "shop_costs", precision: 8, scale: 2, default: "0.0"
    t.decimal "hyport", precision: 8, scale: 2, default: "0.0"
    t.index ["commission_statement_id"], name: "index_franchise_profits_on_commission_statement_id"
    t.index ["development_director_uuid"], name: "index_franchise_profits_on_development_director_uuid"
    t.index ["entity_uuid"], name: "index_franchise_profits_on_entity_uuid"
    t.index ["franchise_statement_id"], name: "index_franchise_profits_on_franchise_statement_id"
    t.index ["publication_uuid"], name: "index_franchise_profits_on_publication_uuid"
    t.index ["publish_on"], name: "index_franchise_profits_on_publish_on"
    t.index ["region_director_uuid"], name: "index_franchise_profits_on_region_director_uuid"
    t.index ["sales_director_uuid"], name: "index_franchise_profits_on_sales_director_uuid"
    t.index ["user_commission_report_id"], name: "index_franchise_profits_on_user_commission_report_id"
    t.index ["user_uuid"], name: "index_franchise_profits_on_user_uuid"
  end

  create_table "franchise_statement_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "franchise_statement_id"
    t.integer "commission_component_id"
    t.decimal "gross", precision: 8, scale: 2, default: "0.0"
    t.decimal "net", precision: 8, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role_id"
    t.index ["commission_component_id"], name: "index_franchise_statement_items_on_commission_component_id"
    t.index ["franchise_statement_id"], name: "index_franchise_statement_items_on_franchise_statement_id"
    t.index ["role_id"], name: "index_franchise_statement_items_on_role_id"
  end

  create_table "franchise_statements", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "publication_id"
    t.integer "business_id"
    t.integer "office_id"
    t.integer "entity_id"
    t.integer "commission_statement_id"
    t.date "start_on"
    t.date "end_on"
    t.decimal "gross", precision: 12, scale: 2, default: "0.0"
    t.decimal "net", precision: 12, scale: 2, default: "0.0"
    t.datetime "finalized_at"
    t.boolean "on_hold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role_id"
    t.integer "employee_number"
    t.bigint "edition_id"
    t.index ["business_id"], name: "index_franchise_statements_on_business_id"
    t.index ["commission_statement_id"], name: "index_franchise_statements_on_commission_statement_id"
    t.index ["edition_id"], name: "index_franchise_statements_on_edition_id"
    t.index ["employee_number"], name: "index_franchise_statements_on_employee_number"
    t.index ["entity_id"], name: "index_franchise_statements_on_entity_id"
    t.index ["office_id"], name: "index_franchise_statements_on_office_id"
    t.index ["publication_id"], name: "index_franchise_statements_on_publication_id"
    t.index ["role_id"], name: "index_franchise_statements_on_role_id"
  end

  create_table "group_role_sets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_group_role_sets_on_name", unique: true
    t.index ["uuid"], name: "index_group_role_sets_on_uuid", unique: true
  end

  create_table "group_role_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.bigint "role_type_id", null: false
    t.bigint "group_role_id", null: false
    t.bigint "group_role_set_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_role_id"], name: "index_group_role_types_on_group_role_id"
    t.index ["group_role_set_id"], name: "index_group_role_types_on_group_role_set_id"
    t.index ["role_type_id", "group_role_set_id"], name: "index_group_role_types_on_role_type_id_and_group_role_set_id", unique: true
    t.index ["role_type_id"], name: "index_group_role_types_on_role_type_id"
    t.index ["uuid"], name: "index_group_role_types_on_uuid", unique: true
  end

  create_table "group_roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_group_roles_on_name", unique: true
    t.index ["uuid"], name: "index_group_roles_on_uuid", unique: true
  end

  create_table "holiday_deadlines", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "month", null: false
    t.integer "deadline", null: false
    t.integer "days_early", default: 15, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "id_changes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "class_name", null: false
    t.integer "old_id", null: false
    t.integer "new_id", null: false
    t.datetime "changed_at"
    t.index ["class_name", "new_id"], name: "index_id_changes_on_class_name_and_new_id"
  end

  create_table "index_categories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "status", default: "active", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "industry"
    t.string "uuid", null: false
    t.index ["name"], name: "index_categories_name_uq", unique: true
  end

  create_table "invoice_fields", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.integer "order_id"
    t.integer "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "fk_invoice_fields_o2_invoices"
    t.index ["order_id"], name: "fk_invoice_fields_o2_orders"
  end

  create_table "job_report_subscriptions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.text "jobs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "subscribed_to_all", default: false
    t.index ["user_id"], name: "index_job_report_subscriptions_on_user_id"
  end

  create_table "kafka_message_logs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "message"
    t.string "uuid"
    t.string "topic"
    t.boolean "delivered"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic"], name: "index_kafka_message_logs_on_topic"
    t.index ["uuid"], name: "index_kafka_message_logs_on_uuid"
  end

  create_table "late_fee_credits", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id", null: false
    t.date "month", null: false
    t.integer "commission_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "commission_report_detail_id"
    t.boolean "bonus", default: false, null: false
    t.string "commission_report_type"
    t.integer "commission_item_id"
    t.text "note"
    t.index ["commission_item_id"], name: "index_late_fee_credits_on_commission_item_id"
    t.index ["commission_report_detail_id"], name: "fk_late_fee_credits_commission_report_detail"
    t.index ["commission_report_id", "commission_report_type"], name: "index_late_fee_credits_comm_report"
    t.index ["user_id"], name: "fk_late_fee_credits_user"
  end

  create_table "market_rates", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "publication_id"
    t.integer "user_id"
    t.integer "ad_type_id"
    t.integer "ad_placement_id"
    t.integer "duration"
    t.integer "home_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal "price", precision: 8, scale: 2
    t.index ["ad_placement_id"], name: "index_market_rates_on_ad_placement_id"
    t.index ["ad_type_id"], name: "index_market_rates_on_ad_type_id"
    t.index ["publication_id"], name: "index_market_rates_on_publication_id"
    t.index ["user_id"], name: "index_market_rates_on_user_id"
  end

  create_table "milestone_thresholds", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "number_of_commissions", default: 0, null: false
    t.integer "revenue_level", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "latest_month", default: false
    t.boolean "maximum_commission", default: false
  end

  create_table "milestones", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "milestone_threshold_id", null: false
    t.decimal "revenue", precision: 10, scale: 2
    t.date "commission_on"
    t.integer "paid_months_to_threshold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "edition_date"
    t.index ["milestone_threshold_id"], name: "index_milestones_on_milestone_threshold_id"
    t.index ["user_id"], name: "index_milestones_on_user_id"
  end

  create_table "mime_types", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "mime_type", null: false
    t.boolean "reject", default: false, null: false
    t.integer "uploaded", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["mime_type"], name: "index_mime_types_on_mime_type", unique: true
  end

  create_table "non_qualifying_reasons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "qualifying_sale_id", null: false
    t.string "field"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["qualifying_sale_id"], name: "index_non_qualifying_reasons_on_qualifying_sale_id"
  end

  create_table "notes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "notable_type", null: false
    t.integer "notable_id", null: false
    t.boolean "private", default: false, null: false
    t.string "state", default: "Unknown"
    t.boolean "archived", default: false
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.index ["created_by_id"], name: "index_notes_on_created_by_id"
    t.index ["notable_type", "notable_id"], name: "index_notes_on_notable_type_and_notable_id"
    t.index ["updated_by_id"], name: "index_notes_on_updated_by_id"
    t.index ["user_id"], name: "fk_notes_user"
  end

  create_table "o2_ad_publications", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "ad_id"
    t.integer "year"
    t.integer "month"
    t.decimal "price", precision: 8, scale: 2
    t.decimal "tradeout", precision: 8, scale: 2, default: "0.0"
    t.text "comments"
    t.integer "order_item_id"
    t.datetime "set_free_on"
    t.boolean "delayed_payment_approved", default: false
    t.boolean "not_run", default: false
    t.datetime "cancelled_on"
    t.integer "cancelled_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "value", precision: 8, scale: 2
    t.boolean "pending_debit_credit_added", default: false
    t.integer "run_override", default: 0
    t.integer "ad_key_order"
    t.integer "ad_key_publication"
    t.string "ad_key_category"
    t.integer "clicked_run_by_id"
    t.date "edition_date"
    t.integer "client_id", null: false
    t.string "publication_type", null: false
    t.integer "ad_type_id"
    t.integer "ad_placement_id"
    t.integer "index_category_id"
    t.integer "publication_id"
    t.integer "advisory_board_category_id"
    t.integer "ad_sponsorship_id"
    t.integer "edition_id"
    t.integer "social_marketing", default: 0, null: false
    t.decimal "discount_applied", precision: 8, scale: 2, default: "0.0"
    t.string "ad_key_order_gid"
    t.index ["ad_key_category"], name: "index_o2_ad_publications_on_ad_key_category"
    t.index ["ad_key_order"], name: "index_o2_ad_publications_on_ad_key_order"
    t.index ["ad_key_order_gid"], name: "index_o2_ad_publications_on_ad_key_order_gid"
    t.index ["ad_key_publication"], name: "index_o2_ad_publications_on_ad_key_publication"
    t.index ["advisory_board_category_id"], name: "index_o2_ad_publications_on_advisory_board_category_id"
    t.index ["cancelled_by_id"], name: "index_o2_ad_publications_on_cancelled_by_id"
    t.index ["clicked_run_by_id"], name: "index_o2_ad_publications_on_clicked_run_by_id"
    t.index ["client_id"], name: "index_o2_ad_publications_on_client_id"
    t.index ["edition_date"], name: "index_o2_ad_publications_on_edition_date"
    t.index ["edition_id"], name: "index_o2_ad_publications_on_edition_id"
    t.index ["id"], name: "index_o2_ad_publications_on_id"
    t.index ["month"], name: "index_o2_ad_publications_on_month"
    t.index ["order_item_id"], name: "fk_o2_ad_publications_o2_order_items"
    t.index ["publication_id"], name: "index_o2_ad_publications_on_publication_id"
    t.index ["run_override"], name: "index_o2_ad_publications_on_run_override"
    t.index ["year"], name: "index_o2_ad_publications_on_year"
  end

  create_table "o2_ad_schedules", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "order_item_id"
    t.integer "order_id"
    t.date "start_on"
    t.integer "duration"
    t.date "end_on"
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "confirmed_by"
    t.bigint "qualifying_sale_id"
    t.index ["confirmed_by"], name: "fk_o2_ad_schedules_users"
    t.index ["order_id"], name: "fk_o2_ad_schedules_o2_orders"
    t.index ["order_item_id"], name: "fk_o2_ad_schedules_o2_order_items"
    t.index ["qualifying_sale_id"], name: "index_o2_ad_schedules_on_qualifying_sale_id"
  end

  create_table "o2_design_invoice_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "invoice_id"
    t.integer "design_item_id"
    t.decimal "amount", precision: 8, scale: 2
    t.decimal "open_amount", precision: 8, scale: 2
    t.string "publication_name"
    t.string "display_group"
    t.boolean "cancelled", default: false, null: false
    t.date "deadline_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["design_item_id"], name: "index_o2_design_invoice_items_on_design_item_id"
    t.index ["invoice_id"], name: "index_o2_design_invoice_items_on_invoice_id"
  end

  create_table "o2_disputes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "receipt_id", null: false
    t.string "status", limit: 4, default: "new", null: false
    t.string "reason"
    t.datetime "resolved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "echeck_return_code", limit: 3
    t.index ["receipt_id"], name: "fk_o2_disputes_o2_receipts"
  end

  create_table "o2_hyport_cycles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "client_id", null: false
    t.integer "order_item_id"
    t.integer "ad_type_id"
    t.integer "year"
    t.integer "month"
    t.decimal "price", precision: 8, scale: 2
    t.string "publication_type", null: false
    t.integer "ad_key_order"
    t.string "ad_key_order_gid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_on"
    t.date "end_on"
    t.integer "ad_placement_id"
    t.index ["ad_key_order"], name: "index_o2_hyport_cycles_on_ad_key_order"
    t.index ["ad_key_order_gid"], name: "index_o2_hyport_cycles_on_ad_key_order_gid"
    t.index ["ad_type_id"], name: "index_o2_hyport_cycles_on_ad_type_id"
    t.index ["client_id"], name: "index_o2_hyport_cycles_on_client_id"
    t.index ["end_on"], name: "index_o2_hyport_cycles_on_end_on"
    t.index ["order_item_id"], name: "index_o2_hyport_cycles_on_order_item_id"
    t.index ["start_on"], name: "index_o2_hyport_cycles_on_start_on"
  end

  create_table "o2_hyport_invoice_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "invoice_id"
    t.bigint "hyport_cycle_id"
    t.decimal "amount", precision: 8, scale: 2
    t.decimal "open_amount", precision: 8, scale: 2
    t.boolean "cancelled", default: false
    t.string "display_group"
    t.integer "ad_key_order"
    t.integer "ad_key_publication"
    t.string "ad_key_category"
    t.string "ad_key_order_gid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ad_type_name"
    t.date "deadline_date"
    t.boolean "delinquent", default: false
    t.index ["ad_key_category"], name: "index_o2_hyport_invoice_items_on_ad_key_category"
    t.index ["ad_key_order"], name: "index_o2_hyport_invoice_items_on_ad_key_order"
    t.index ["ad_key_order_gid"], name: "index_o2_hyport_invoice_items_on_ad_key_order_gid"
    t.index ["ad_key_publication"], name: "index_o2_hyport_invoice_items_on_ad_key_publication"
    t.index ["hyport_cycle_id"], name: "index_o2_hyport_invoice_items_on_hyport_cycle_id"
    t.index ["invoice_id"], name: "index_o2_hyport_invoice_items_on_invoice_id"
  end

  create_table "o2_invoice_item_receipt_refunds", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "refund_id", null: false
    t.integer "invoice_item_receipt_id", null: false
    t.decimal "amount", precision: 8, scale: 2, null: false
    t.boolean "refunded_unpaid", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ad_key_order"
    t.integer "ad_key_publication"
    t.string "ad_key_category"
    t.string "ad_key_order_gid"
    t.index ["ad_key_category"], name: "index_o2_invoice_item_receipt_refunds_on_ad_key_category"
    t.index ["ad_key_order"], name: "index_o2_invoice_item_receipt_refunds_on_ad_key_order"
    t.index ["ad_key_order_gid"], name: "index_o2_invoice_item_receipt_refunds_on_ad_key_order_gid"
    t.index ["ad_key_publication"], name: "index_o2_invoice_item_receipt_refunds_on_ad_key_publication"
    t.index ["invoice_item_receipt_id"], name: "fk_o2_invoice_item_receipt_refunds_o2_invoice_item_receipts"
    t.index ["refund_id"], name: "fk_o2_invoice_item_receipt_refunds_o2_refunds"
  end

  create_table "o2_invoice_item_receipts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "receipt_id"
    t.integer "invoice_item_id"
    t.decimal "amount", precision: 8, scale: 2
    t.string "invoice_item_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ad_key_order"
    t.integer "ad_key_publication"
    t.string "ad_key_category"
    t.string "ad_key_order_gid"
    t.index ["ad_key_category"], name: "index_o2_invoice_item_receipts_on_ad_key_category"
    t.index ["ad_key_order"], name: "index_o2_invoice_item_receipts_on_ad_key_order"
    t.index ["ad_key_order_gid"], name: "index_o2_invoice_item_receipts_on_ad_key_order_gid"
    t.index ["ad_key_publication"], name: "index_o2_invoice_item_receipts_on_ad_key_publication"
    t.index ["invoice_item_type", "invoice_item_id"], name: "index_o2_invoice_item_receipts_invoice_item", length: { invoice_item_type: 10 }
    t.index ["receipt_id"], name: "fk_o2_invoice_item_receipts_o2_receipts"
  end

  create_table "o2_invoice_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "invoice_id"
    t.decimal "amount", precision: 8, scale: 2
    t.decimal "open_amount", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ad_publication_id"
    t.string "date_description"
    t.string "display_group"
    t.boolean "cancelled", default: false, null: false
    t.string "ad_type_name"
    t.string "neighborhood_name"
    t.string "ad_placement_name"
    t.string "ad_sponsorship_name"
    t.date "deadline_date"
    t.string "publication_name"
    t.integer "ad_key_order"
    t.integer "ad_key_publication"
    t.string "ad_key_category"
    t.string "ad_key_order_gid"
    t.index ["ad_key_category"], name: "index_o2_invoice_items_on_ad_key_category"
    t.index ["ad_key_order"], name: "index_o2_invoice_items_on_ad_key_order"
    t.index ["ad_key_order_gid"], name: "index_o2_invoice_items_on_ad_key_order_gid"
    t.index ["ad_key_publication"], name: "index_o2_invoice_items_on_ad_key_publication"
    t.index ["ad_publication_id"], name: "index_o2_invoice_items_on_ad_publication_id"
    t.index ["deadline_date"], name: "index_o2_invoice_items_on_deadline_date"
    t.index ["display_group"], name: "index_o2_invoice_items_on_display_group"
    t.index ["invoice_id"], name: "fk_o2_invoice_items_o2_invoices"
    t.index ["open_amount"], name: "index_o2_invoice_items_on_open_amount"
  end

  create_table "o2_invoices", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "client_id", null: false
    t.string "invoice_number"
    t.date "invoice_on"
    t.date "due_on"
    t.boolean "emailed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "payment_method_type"
    t.integer "payment_method_id"
    t.string "publication_type", default: "newsletter", null: false
    t.date "publication_date"
    t.string "frequency", default: "monthly", null: false
    t.date "last_retry"
    t.datetime "last_attempted_payment_at"
    t.index ["client_id"], name: "fk_o2_invoices_clients"
    t.index ["due_on"], name: "index_o2_invoices_on_due_on"
    t.index ["payment_method_type", "payment_method_id"], name: "index_o2_invoices_payment_method", length: { payment_method_type: 4 }
  end

  create_table "o2_manual_invoice_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "invoice_id"
    t.string "description"
    t.decimal "amount", precision: 8, scale: 2
    t.decimal "open_amount", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "display_group"
    t.boolean "cancelled", default: false, null: false
    t.index ["invoice_id"], name: "fk_o2_manual_invoice_items_o2_invoices"
  end

  create_table "o2_order_agreement_notifications", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "order_id"
    t.string "mercury_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "mercury_notification", default: false
    t.boolean "email_notification", default: false
    t.index ["order_id"], name: "index_o2_order_agreement_notifications_on_order_id"
  end

  create_table "o2_order_agreements", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "status", default: 0, null: false
    t.integer "agreement_type"
    t.string "title_of_signer"
    t.datetime "signed_on"
    t.boolean "viewed", default: false
    t.index ["order_id"], name: "index_o2_order_agreements_on_order_id"
  end

  create_table "o2_order_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "order_id"
    t.string "type", null: false
    t.string "publication_type", default: "newsletter", null: false
    t.decimal "value", precision: 8, scale: 2, default: "0.0"
    t.decimal "price", precision: 8, scale: 2
    t.decimal "tradeout", precision: 8, scale: 2, default: "0.0"
    t.date "start_on"
    t.integer "duration"
    t.integer "ad_type_id"
    t.integer "ad_sponsorship_id"
    t.integer "ad_placement_id"
    t.integer "parent_item_id"
    t.integer "index_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "confirmed_at"
    t.integer "confirmed_by"
    t.datetime "rejected_at"
    t.integer "rejected_by"
    t.integer "approval_user_id"
    t.string "rejected_reason"
    t.integer "adjusted_item_id"
    t.date "end_on"
    t.integer "invoice_x_months", default: 1, null: false
    t.string "commission_override"
    t.date "contract_created_on"
    t.string "approval_rule"
    t.integer "publication_id"
    t.string "uuid", limit: 36, null: false
    t.integer "ad_key_order"
    t.integer "ad_key_publication"
    t.string "ad_key_category"
    t.boolean "display_cross_selling", default: false
    t.integer "advisory_board_category_id"
    t.string "approval_user_type"
    t.boolean "override_value", default: false
    t.decimal "discount_applied", precision: 8, scale: 2, default: "0.0"
    t.string "ad_key_order_gid"
    t.text "sales_notes"
    t.json "custom_options"
    t.index ["ad_key_category"], name: "index_o2_order_items_on_ad_key_category"
    t.index ["ad_key_order"], name: "index_o2_order_items_on_ad_key_order"
    t.index ["ad_key_order_gid"], name: "index_o2_order_items_on_ad_key_order_gid"
    t.index ["ad_key_publication"], name: "index_o2_order_items_on_ad_key_publication"
    t.index ["ad_placement_id"], name: "fk_o2_order_items_ad_placements"
    t.index ["ad_sponsorship_id"], name: "fk_o2_order_items_ad_sponsorships"
    t.index ["ad_type_id"], name: "fk_o2_order_items_ad_types"
    t.index ["adjusted_item_id"], name: "fk_o2_order_items_adjusted_item_id"
    t.index ["advisory_board_category_id"], name: "index_o2_order_items_on_advisory_board_category_id"
    t.index ["approval_user_id"], name: "index_o2_order_items_on_approval_user_id"
    t.index ["approval_user_type", "approval_user_id"], name: "index_o2_order_items_on_approval_user_type_and_approval_user_id"
    t.index ["confirmed_by"], name: "index_o2_order_items_on_confirmed_by"
    t.index ["index_category_id"], name: "fk_o2_order_items_index_category_id"
    t.index ["order_id"], name: "fk_o2_order_items_o2_orders"
    t.index ["parent_item_id"], name: "fk_o2_order_items_parent_item_id"
    t.index ["publication_id"], name: "index_o2_order_items_on_publication_id"
    t.index ["publication_type"], name: "index_o2_order_items_on_publication_type"
    t.index ["rejected_by"], name: "index_o2_order_items_on_rejected_by"
    t.index ["type"], name: "index_o2_order_items_on_type"
  end

  create_table "o2_orders", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "kind", null: false
    t.integer "sales_rep_id"
    t.integer "client_id"
    t.integer "invoice_x_months", default: 1, null: false
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "payment_method_type"
    t.integer "payment_method_id"
    t.string "status", default: "new", null: false
    t.integer "created_by_user_id"
    t.decimal "tradeout", precision: 8, scale: 2
    t.integer "office_id"
    t.integer "step", default: 1
    t.string "entry"
    t.text "initials_payment"
    t.text "initials_cancellation"
    t.text "contract_signature"
    t.text "initials_exclusivity"
    t.string "signer_title"
    t.boolean "acknowledge_signature"
    t.string "preconfirmation_rule"
    t.string "preconfirmation_selection"
    t.json "expected_managing_reps"
    t.integer "social_marketing", default: 2, null: false
    t.string "uuid", limit: 36
    t.string "source_token"
    t.integer "sale_assisted_by_user_id"
    t.index ["client_id"], name: "fk_o2_orders_clients"
    t.index ["created_by_user_id"], name: "fk_o2_orders_created_by_user"
    t.index ["kind", "status"], name: "index_o2_orders_on_kind_and_status"
    t.index ["office_id"], name: "index_o2_orders_on_office_id"
    t.index ["payment_method_type", "payment_method_id"], name: "index_o2_orders_on_payment_method_type_and_payment_method_id"
    t.index ["preconfirmation_rule"], name: "index_o2_orders_on_preconfirmation_rule"
    t.index ["sales_rep_id"], name: "fk_o2_orders_users"
    t.index ["uuid"], name: "index_o2_orders_on_uuid", unique: true
  end

  create_table "o2_receipts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "client_id"
    t.date "received_on"
    t.decimal "amount", precision: 8, scale: 2
    t.integer "transaction_id"
    t.string "check_number", limit: 30
    t.boolean "bad_debt", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tradeout_order_id"
    t.boolean "credit", default: false, null: false
    t.string "reason"
    t.integer "check_batch_id"
    t.string "billing_key"
    t.string "kind"
    t.integer "business_id"
    t.index ["check_batch_id"], name: "fk_o2_receipts_check_batch_id"
    t.index ["check_number"], name: "index_o2_receipts_on_check_number"
    t.index ["client_id"], name: "fk_o2_receipts_clients"
    t.index ["tradeout_order_id"], name: "fk_o2_receipts_tradeout_order_id"
    t.index ["transaction_id"], name: "fk_o2_receipts_o2_transactions"
  end

  create_table "o2_refunds", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "client_id", null: false
    t.integer "dispute_id"
    t.decimal "amount", precision: 8, scale: 2, null: false
    t.string "reason", limit: 50
    t.string "refund_method", limit: 11, null: false
    t.string "check_number", limit: 30
    t.date "check_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "fk_o2_refunds_clients"
    t.index ["dispute_id"], name: "fk_o2_refunds_o2_disputes"
  end

  create_table "o2_shop_invoice_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "invoice_id"
    t.decimal "amount", precision: 8, scale: 2
    t.decimal "open_amount", precision: 8, scale: 2
    t.string "shoppable_type"
    t.bigint "shoppable_id"
    t.boolean "cancelled", default: false
    t.string "display_group"
    t.integer "ad_key_order"
    t.integer "ad_key_publication"
    t.string "ad_key_category"
    t.string "ad_key_order_gid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_key_order_gid"], name: "index_o2_shop_invoice_items_on_ad_key_order_gid"
    t.index ["invoice_id"], name: "index_o2_shop_invoice_items_on_invoice_id"
    t.index ["shoppable_type", "shoppable_id"], name: "index_o2_shop_invoice_items_on_shoppable_type_and_shoppable_id"
  end

  create_table "o2_transactions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "payment_method_id"
    t.string "payment_method_type"
    t.decimal "amount", precision: 10, scale: 2
    t.boolean "success", default: false, null: false
    t.text "status_message"
    t.string "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "refund_id"
    t.index ["identifier"], name: "index_o2_transactions_on_identifier"
    t.index ["payment_method_type", "payment_method_id"], name: "index_o2_transactions_payment_method", length: { payment_method_type: 4 }
    t.index ["refund_id"], name: "fk_o2_transactions_o2_refunds"
  end

  create_table "office_deadlines", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "office_id", null: false
    t.integer "year", null: false
    t.integer "month", null: false
    t.date "deadline", null: false
    t.index ["office_id", "year", "month"], name: "index_office_deadlines_on_office_id_and_year_and_month"
  end

  create_table "office_defaults", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id"
    t.integer "deadline_distance"
    t.string "phone"
    t.integer "pay_period_day"
    t.decimal "ad_value_percentage", precision: 10, default: "9"
    t.boolean "email_paid_invoices", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_office_defaults_on_user_id"
  end

  create_table "offices", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.integer "parent_id", default: 1
    t.string "kind", limit: 10
    t.datetime "updated_at", null: false
    t.string "status", limit: 10, default: "active", null: false
    t.integer "deadline_day", limit: 1, default: 1, null: false
    t.datetime "created_at", null: false
    t.string "handle", limit: 50, null: false
    t.integer "deadline_distance", default: 1, null: false
    t.string "phone", limit: 15
    t.decimal "ad_value_percentage", precision: 5, scale: 3, default: "15.0"
    t.boolean "email_paid_invoices", default: true, null: false
    t.integer "position"
    t.string "uuid", limit: 36, null: false
    t.integer "business_id", default: 1
    t.integer "entity_id"
    t.index ["business_id"], name: "index_offices_on_business_id"
    t.index ["entity_id"], name: "index_offices_on_entity_id"
    t.index ["name"], name: "index_offices_on_name", unique: true
  end

  create_table "order_agreement_signatures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "signature_kind"
    t.text "signature_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_agreement_id"
    t.string "entered_signature"
    t.index ["order_agreement_id"], name: "index_order_agreement_signatures_on_order_agreement_id"
  end

  create_table "override_commission_estimates", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "profitability_estimate_id"
    t.integer "user_id"
    t.integer "office_id"
    t.decimal "amount", precision: 8, scale: 2, default: "0.0"
    t.decimal "override", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["office_id"], name: "index_override_commission_estimates_on_office_id"
    t.index ["profitability_estimate_id"], name: "index_override_commission_estimates_on_profitability_estimate_id"
    t.index ["user_id"], name: "index_override_commission_estimates_on_user_id"
  end

  create_table "override_commissions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "paid_from_user_id", null: false
    t.integer "paid_to_user_id", null: false
    t.decimal "commission", precision: 8, scale: 2, default: "0.0", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "type"
    t.integer "to_office_id"
    t.index ["paid_from_user_id"], name: "index_override_commissions_on_paid_from_user_id"
    t.index ["paid_to_user_id"], name: "index_override_commissions_on_paid_to_user_id"
    t.index ["to_office_id"], name: "index_override_commissions_on_to_office_id"
    t.index ["type"], name: "index_override_commissions_on_type"
  end

  create_table "page_layouts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "page_layouts_businesses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "page_layout_id"
    t.integer "business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_page_layouts_businesses_on_business_id"
    t.index ["page_layout_id"], name: "index_page_layouts_businesses_on_page_layout_id"
  end

  create_table "page_layouts_publication_types", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "page_layout_id"
    t.integer "publication_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_layout_id"], name: "index_page_layouts_publication_types_on_page_layout_id"
    t.index ["publication_type_id"], name: "index_page_layouts_publication_types_on_publication_type_id"
  end

  create_table "paid_override_commissions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "commission_report_id"
    t.integer "from_commission_report_id"
    t.decimal "percent", precision: 8, scale: 2
    t.decimal "amount", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "commission_statement_id"
    t.integer "from_commission_statement_id"
    t.integer "override_commission_id"
    t.decimal "gross", precision: 8, scale: 2
    t.index ["commission_report_id"], name: "index_paid_override_commissions_on_commission_report_id"
    t.index ["commission_statement_id"], name: "index_paid_override_commissions_on_commission_statement_id"
    t.index ["from_commission_report_id"], name: "index_paid_override_commissions_on_from_commission_report_id"
    t.index ["from_commission_statement_id"], name: "index_paid_override_commissions_on_from_commission_statement_id"
    t.index ["override_commission_id"], name: "index_paid_override_commissions_on_override_commission_id"
  end

  create_table "pay_infos", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "sales_rep_id"
    t.integer "office_id"
    t.date "start_on"
    t.date "end_on"
    t.integer "business_id"
    t.string "commission_type"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sales_role"
    t.integer "publication_id"
    t.boolean "inactive", default: false
    t.string "order_type"
    t.integer "product_line_id"
    t.index ["business_id"], name: "index_pay_infos_on_business_id"
    t.index ["commission_type"], name: "index_pay_infos_on_commission_type"
    t.index ["office_id"], name: "index_pay_infos_on_office_id"
    t.index ["order_id"], name: "index_pay_infos_on_order_id"
    t.index ["order_type", "order_id"], name: "index_pay_infos_on_order_type_and_order_id"
    t.index ["product_line_id"], name: "index_pay_infos_on_product_line_id"
    t.index ["publication_id"], name: "index_pay_infos_on_publication_id"
    t.index ["sales_rep_id"], name: "index_pay_infos_on_sales_rep_id"
  end

  create_table "pay_period_days", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "business_id"
    t.integer "day"
    t.integer "entity_id"
    t.index ["business_id"], name: "index_pay_period_days_on_business_id"
  end

  create_table "pay_periods", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id"
    t.integer "start_day", null: false
    t.date "start_on", default: "1980-01-01"
    t.date "end_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "entity_id"
    t.integer "business_id"
    t.integer "office_id"
    t.index ["business_id"], name: "index_pay_periods_on_business_id"
    t.index ["entity_id"], name: "index_pay_periods_on_entity_id"
    t.index ["office_id"], name: "index_pay_periods_on_office_id"
    t.index ["user_id"], name: "fk_pay_periods_users"
  end

  create_table "pay_schemes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "seller"
    t.integer "receiver"
    t.integer "n2"
    t.boolean "upfront", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pay_types", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "ad_scheme_id"
    t.integer "design_scheme_id"
    t.integer "cross_ad_scheme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "direct_to_rep", default: false, null: false
    t.string "kind", default: "custom", null: false
    t.string "description", null: false
    t.string "cross_description"
    t.string "standard_description"
    t.bigint "shop_product_scheme_id"
    t.index ["ad_scheme_id"], name: "index_pay_types_on_ad_scheme_id"
    t.index ["cross_ad_scheme_id"], name: "index_pay_types_on_cross_ad_scheme_id"
    t.index ["design_scheme_id"], name: "index_pay_types_on_design_scheme_id"
    t.index ["shop_product_scheme_id"], name: "index_pay_types_on_shop_product_scheme_id"
  end

  create_table "pending_debit_credits", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "ad_publication_id"
    t.date "on_date"
    t.integer "office_id"
    t.decimal "value", precision: 8, scale: 2
    t.decimal "ad_value_percentage", precision: 5, scale: 3
    t.integer "commission_report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "order_item_id"
    t.integer "commission_statement_id"
    t.index ["ad_publication_id"], name: "index_pending_debit_credits_on_ad_publication_id"
    t.index ["commission_report_id"], name: "index_pending_debit_credits_on_commission_report_id"
    t.index ["commission_statement_id"], name: "index_pending_debit_credits_on_commission_statement_id"
    t.index ["office_id"], name: "index_pending_debit_credits_on_office_id"
    t.index ["order_item_id"], name: "index_pending_debit_credits_on_order_item_id"
    t.index ["user_id"], name: "index_pending_debit_credits_on_user_id"
  end

  create_table "product_lines", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "uuid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "display"
    t.text "search_terms"
    t.string "logo"
  end

  create_table "production_cost_sheets", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "publish_on"
    t.date "approval_date"
    t.string "printer"
    t.string "color_type"
    t.string "creative_director"
    t.boolean "first_month"
    t.integer "page_count"
    t.integer "print_count"
    t.integer "print_variance"
    t.integer "publication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "commission_report_id"
    t.integer "franchise_statement_id"
    t.bigint "edition_id"
    t.index ["commission_report_id"], name: "index_production_cost_sheets_on_commission_report_id"
    t.index ["edition_id"], name: "index_production_cost_sheets_on_edition_id"
    t.index ["publication_id"], name: "index_production_cost_sheets_on_publication_id"
    t.index ["publish_on"], name: "index_production_cost_sheets_on_publish_on"
  end

  create_table "production_fees", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "fee_type"
    t.integer "count", null: false
    t.integer "amount", null: false
    t.integer "cost_sheet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cost_sheet_type"
    t.index ["cost_sheet_id", "cost_sheet_type", "fee_type"], name: "index_production_fees_on_cost_sheet_and_fee_type", unique: true
    t.index ["cost_sheet_id"], name: "index_production_fees_on_cost_sheet_id"
    t.index ["cost_sheet_type", "cost_sheet_id"], name: "index_production_fees_on_cost_sheet_type_and_cost_sheet_id"
  end

  create_table "production_revision_dates", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "revised_at"
    t.integer "cost_sheet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cost_sheet_type"
    t.index ["cost_sheet_id"], name: "index_production_revision_dates_on_cost_sheet_id"
    t.index ["cost_sheet_type", "cost_sheet_id"], name: "index_revision_dates_on_cost_sheet_type_and_cost_sheet_id"
  end

  create_table "production_social_marketing_clients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "production_cost_sheet_id"
    t.string "client_uuid"
    t.date "publish_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_uuid"], name: "index_production_social_marketing_clients_on_client_uuid"
    t.index ["production_cost_sheet_id"], name: "index_social_marketing_clients_on_pcs_id"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.bigint "product_line_id", null: false
    t.integer "frequency", default: 0, null: false
    t.integer "frequency_type", default: 0, null: false
    t.string "name", null: false
    t.string "display"
    t.string "abbreviation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.index ["name"], name: "index_products_on_name", unique: true
    t.index ["product_line_id"], name: "index_products_on_product_line_id"
    t.index ["uuid"], name: "index_products_on_uuid", unique: true
  end

  create_table "profitability_estimates", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id"
    t.integer "office_id"
    t.decimal "expenses", precision: 8, scale: 2, default: "0.0"
    t.decimal "reimbursements", precision: 8, scale: 2, default: "0.0"
    t.decimal "pending_debit_credits", precision: 8, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number_of_months", default: 9
    t.decimal "ad_management_rebates", precision: 8, scale: 2, default: "0.0"
    t.index ["office_id"], name: "index_profitability_estimates_on_office_id"
    t.index ["user_id"], name: "index_profitability_estimates_on_user_id"
  end

  create_table "publication_assignments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.bigint "user_id", null: false
    t.bigint "publication_id", null: false
    t.bigint "role_type_id", null: false
    t.date "start_on", null: false
    t.date "end_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id"], name: "index_publication_assignments_on_publication_id"
    t.index ["role_type_id"], name: "index_publication_assignments_on_role_type_id"
    t.index ["user_id"], name: "index_publication_assignments_on_user_id"
    t.index ["uuid"], name: "index_publication_assignments_on_uuid", unique: true
  end

  create_table "publication_costs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description"
    t.decimal "cost", precision: 8, scale: 2
    t.date "start_on"
    t.date "end_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "publication_type"
    t.boolean "qualify_for_rebate", default: false
    t.index ["publication_type", "description", "start_on"], name: "by_pub_type_description_start_on", unique: true
  end

  create_table "publication_estimates", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "publication_type"
    t.boolean "color"
    t.integer "pages"
    t.integer "subscribers"
    t.decimal "cost", precision: 8, scale: 2, default: "0.0"
    t.decimal "override", precision: 8, scale: 2
    t.integer "profitability_estimate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "publication_id"
    t.index ["profitability_estimate_id"], name: "index_publication_estimates_on_profitability_estimate_id"
    t.index ["publication_id"], name: "index_publication_estimates_on_publication_id"
  end

  create_table "publication_freights", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "pages"
    t.integer "subscribers"
    t.integer "publication_type_id"
    t.decimal "unit_cost", precision: 5, scale: 4
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pages"], name: "index_publication_freights_on_pages"
    t.index ["publication_type_id"], name: "index_publication_freights_on_publication_type_id"
    t.index ["subscribers"], name: "index_publication_freights_on_subscribers"
  end

  create_table "publication_histories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "start_on"
    t.date "end_on"
    t.integer "office_id"
    t.integer "publication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "entity_id"
    t.index ["entity_id"], name: "index_publication_histories_on_entity_id"
    t.index ["office_id"], name: "index_publication_histories_on_office_id"
    t.index ["publication_id"], name: "index_publication_histories_on_publication_id"
  end

  create_table "publication_pages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "pages", null: false
    t.decimal "print_bw", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "shipping", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "design_bw", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "design_color", precision: 8, scale: 2, default: "0.0", null: false
    t.integer "publication_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pages", "publication_type_id"], name: "index_publication_pages_on_pages_and_publication_type_id", unique: true
    t.index ["publication_type_id"], name: "index_publication_pages_on_publication_type_id"
  end

  create_table "publication_pages_color_costs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "pages"
    t.integer "subscribers"
    t.decimal "print_color", precision: 8, scale: 2
    t.integer "publication_type_id"
    t.decimal "override_cost", precision: 10
    t.index ["publication_type_id"], name: "index_publication_pages_color_costs_on_publication_type_id"
  end

  create_table "publication_shipping_costs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "pages", null: false
    t.integer "minimum_subscribers", null: false
    t.decimal "unit_cost", precision: 8, scale: 4, default: "0.0", null: false
    t.integer "publication_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "flat_cost", default: false, null: false
    t.index ["minimum_subscribers", "pages", "publication_type_id"], name: "index_shipping_costs_on_subscribers_pages_pub_type_id", unique: true
    t.index ["minimum_subscribers"], name: "index_publication_shipping_costs_on_minimum_subscribers"
    t.index ["pages"], name: "index_publication_shipping_costs_on_pages"
    t.index ["publication_type_id"], name: "index_publication_shipping_costs_on_publication_type_id"
  end

  create_table "publication_subscribers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "minimum", null: false
    t.integer "maximum", null: false
    t.decimal "admin_cost", precision: 8, scale: 2, default: "0.0", null: false
    t.boolean "allow_color", default: false, null: false
    t.integer "publication_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["minimum", "maximum", "publication_type_id"], name: "index_publication_subscribers_on_minimum_and_maximum", unique: true
    t.index ["publication_type_id"], name: "index_publication_subscribers_on_publication_type_id"
  end

  create_table "publication_types", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "frequency"
    t.string "display"
    t.boolean "charge_freight", default: false, null: false
    t.integer "growth_director_id"
    t.bigint "product_line_id"
    t.decimal "minimum_ad_size", precision: 6, scale: 5
    t.boolean "digital", default: false
    t.boolean "active", default: false, null: false
    t.string "uuid", limit: 36
    t.index ["growth_director_id"], name: "index_publication_types_on_growth_director_id"
    t.index ["name"], name: "index_publication_types_on_name"
    t.index ["product_line_id"], name: "index_publication_types_on_product_line_id"
  end

  create_table "publications", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "neighborhood_name"
    t.string "handle"
    t.string "publication_type"
    t.integer "homes"
    t.date "start_on"
    t.date "end_on"
    t.boolean "mobile_app"
    t.string "hoa_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "office_id"
    t.string "uuid", limit: 36
    t.date "franchisee_signed_on"
    t.text "franchise_closure_notes"
    t.decimal "franchise_fee_owed", precision: 10
    t.boolean "use_market_rate", default: false
    t.integer "edition_advertorial_quota"
    t.string "zipcode"
    t.string "latitude"
    t.string "longitude"
    t.string "city", limit: 50
    t.string "state", limit: 50
    t.date "last_edition_date"
    t.integer "finishing_type", default: 0
    t.integer "target_publish_month"
    t.integer "previous_publication_id"
    t.boolean "inbound_leads_program", default: false, null: false
    t.date "inbound_leads_program_toggle_date"
    t.index ["inbound_leads_program"], name: "index_publications_on_inbound_leads_program"
    t.index ["inbound_leads_program_toggle_date"], name: "index_publications_on_inbound_leads_program_toggle_date"
    t.index ["office_id"], name: "index_publications_on_office_id"
    t.index ["publication_type"], name: "index_publications_on_publication_type"
    t.index ["uuid"], name: "index_publications_on_uuid", unique: true
  end

  create_table "qualifying_sale_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "qualifying_sale_id"
    t.integer "order_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_item_id"], name: "index_qualifying_sale_items_on_order_item_id"
    t.index ["qualifying_sale_id"], name: "index_qualifying_sale_items_on_qualifying_sale_id"
  end

  create_table "qualifying_sales", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "client_id"
    t.integer "order_id"
    t.integer "sales_rep_id"
    t.integer "area_director_id"
    t.string "sales_rep_level"
    t.integer "duration"
    t.decimal "average_price", precision: 8, scale: 2
    t.decimal "total_price", precision: 8, scale: 2
    t.date "start_on"
    t.integer "first_invoice_id"
    t.decimal "first_invoice_open_amount", precision: 8, scale: 2
    t.integer "campaign"
    t.integer "business_id"
    t.integer "year"
    t.integer "month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "qualifying", default: true
    t.date "first_invoice_due_on"
    t.string "publication_info"
    t.integer "kind", default: 0
    t.date "cutoff_date"
    t.string "uuid", limit: 36
    t.index ["area_director_id"], name: "index_qualifying_sales_on_area_director_id"
    t.index ["business_id"], name: "index_qualifying_sales_on_business_id"
    t.index ["client_id"], name: "index_qualifying_sales_on_client_id"
    t.index ["first_invoice_due_on"], name: "index_qualifying_sales_on_first_invoice_due_on"
    t.index ["first_invoice_id"], name: "index_qualifying_sales_on_first_invoice_id"
    t.index ["kind"], name: "index_qualifying_sales_on_kind"
    t.index ["order_id"], name: "index_qualifying_sales_on_order_id"
    t.index ["sales_rep_id"], name: "index_qualifying_sales_on_sales_rep_id"
    t.index ["uuid"], name: "index_qualifying_sales_on_uuid", unique: true
  end

  create_table "qualifying_sales_thresholds", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "start_on"
    t.date "end_on"
    t.decimal "average_price", precision: 8, scale: 2
    t.integer "duration"
    t.integer "campaign_months"
    t.integer "business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kind", default: 0
    t.index ["business_id"], name: "index_qualifying_sales_thresholds_on_business_id"
    t.index ["kind"], name: "index_qualifying_sales_thresholds_on_kind"
  end

  create_table "recurring_commission_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "statement_id"
    t.string "statement_type"
    t.integer "recurring_commission_id"
    t.datetime "finalized_at"
    t.decimal "amount", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recurring_commission_id"], name: "index_recurring_commission_items_on_recurring_commission_id"
    t.index ["statement_type", "statement_id"], name: "index_recurring_commission_items_on_statement"
  end

  create_table "recurring_commissions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "description"
    t.string "name"
    t.integer "recurrence_strategy", default: 0
    t.boolean "credit", default: false
    t.decimal "price", precision: 8, scale: 2
    t.decimal "balance", precision: 8, scale: 2
    t.date "start_date"
    t.date "end_date"
    t.integer "duration"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "business_id"
    t.integer "recurrable_id"
    t.string "recurrable_type"
    t.index ["business_id"], name: "index_recurring_commissions_on_business_id"
    t.index ["created_by_id"], name: "index_recurring_commissions_on_created_by_id"
    t.index ["recurrable_type", "recurrable_id"], name: "index_recurring_commissions_on_recurrable_type_and_recurrable_id"
    t.index ["updated_by_id"], name: "index_recurring_commissions_on_updated_by_id"
  end

  create_table "recurring_subscriptions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.decimal "amount", precision: 8, scale: 2
    t.date "start_date"
    t.integer "occurrences"
    t.string "auth_net_id"
    t.string "invoice_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.string "subscribable_type"
    t.bigint "subscribable_id"
    t.string "payment_method_type"
    t.bigint "payment_method_id"
    t.bigint "service_id"
    t.index ["payment_method_type", "payment_method_id"], name: "index_recurring_subscriptions_on_payment_method"
    t.index ["service_id"], name: "index_recurring_subscriptions_on_service_id"
    t.index ["subscribable_type", "subscribable_id"], name: "index_recurring_subscriptions_on_subscribable"
  end

  create_table "rep_assignments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "product_line_id"
    t.bigint "office_id"
    t.bigint "user_id"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "attended_meeting", default: false, null: false
    t.index ["client_id", "product_line_id", "type"], name: "index_rep_assignments_on_client_id_and_product_line_id_and_type", unique: true
    t.index ["client_id"], name: "index_rep_assignments_on_client_id"
    t.index ["office_id"], name: "index_rep_assignments_on_office_id"
    t.index ["product_line_id"], name: "index_rep_assignments_on_product_line_id"
    t.index ["user_id"], name: "index_rep_assignments_on_user_id"
  end

  create_table "resident_business_heading_graphics", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "data_file_size"
    t.integer "width"
    t.integer "height"
    t.integer "ppi"
    t.string "data_content_type"
    t.string "data_file_name"
    t.decimal "height_in_inches", precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "data"
  end

  create_table "resident_business_headings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "resident_business_hg_id"
    t.text "disclaimer"
    t.decimal "vertical_offset", precision: 8, scale: 2, default: "0.0"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["resident_business_hg_id"], name: "resident_business_headings_resident_business_hg_id_fkey"
  end

  create_table "resident_business_listing_uploads", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "resident_business_id", null: false
    t.integer "data_file_size"
    t.string "data_content_type"
    t.string "data_file_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "data"
    t.index ["resident_business_id"], name: "resident_business_listing_uploads_resident_business_id_fkey"
  end

  create_table "resident_business_listings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "resident_business_id", null: false
    t.string "category"
    t.string "business_name"
    t.string "contact_name"
    t.string "phone"
    t.string "email"
    t.string "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["resident_business_id"], name: "resident_business_listings_resident_business_id_fkey"
  end

  create_table "resident_businesses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "year", null: false
    t.integer "month", limit: 2, null: false
    t.text "provided_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "resident_business_heading_id"
    t.integer "publication_id", null: false
    t.index ["publication_id"], name: "index_resident_businesses_on_publication_id"
    t.index ["resident_business_heading_id"], name: "index_resident_businesses_on_resident_business_heading_id"
  end

  create_table "revenue_thresholds", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "business_id"
    t.decimal "minimum", precision: 8, scale: 2
    t.decimal "maximum", precision: 10, scale: 2
    t.decimal "percentage", precision: 8, scale: 2
    t.decimal "baseline_increment", precision: 8, scale: 2
    t.string "role_level"
    t.date "start_on"
    t.date "end_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_revenue_thresholds_on_business_id"
    t.index ["role_level"], name: "index_revenue_thresholds_on_role_level"
  end

  create_table "role_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.string "name", null: false
    t.string "namespace", null: false
    t.string "full_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["full_name"], name: "index_role_types_on_full_name", unique: true
    t.index ["uuid"], name: "index_role_types_on_uuid", unique: true
  end

  create_table "roles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "office_id", null: false
    t.string "level", null: false
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.date "start_on", default: "1980-01-01"
    t.date "end_on"
    t.index ["office_id"], name: "fk_roles_o"
    t.index ["user_id"], name: "fk_roles_u"
  end

  create_table "scheduled_emails", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type"
    t.string "recipients"
    t.text "payload", null: false
    t.date "sent_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["type"], name: "index_scheduled_emails_on_type"
  end

  create_table "sequences", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", null: false
    t.integer "next_number", default: 1, null: false
    t.integer "business_id"
    t.index ["business_id"], name: "index_sequences_on_business_id"
    t.index ["name", "business_id"], name: "index_sequences_on_name_and_business_id"
  end

  create_table "services", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "display_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "setting_type"
  end

  create_table "shop_commission_costs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "shoppable_type"
    t.bigint "shoppable_id"
    t.bigint "franchise_statement_id"
    t.integer "print_count"
    t.integer "page_count"
    t.decimal "cost", precision: 8, scale: 2
    t.decimal "override_cost", precision: 8, scale: 2
    t.boolean "override_scs", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["franchise_statement_id"], name: "index_shop_commission_costs_on_franchise_statement_id"
    t.index ["shoppable_type", "shoppable_id"], name: "index_shop_commission_costs_on_shoppable_type_and_shoppable_id"
  end

  create_table "shop_cost_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "shoppable_type"
    t.integer "page_count"
    t.integer "print_count"
    t.string "option_name"
    t.string "option_choice"
    t.decimal "cost", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shoppable_type"], name: "index_shop_cost_infos_on_shoppable_type"
  end

  create_table "shop_cost_sheets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "print_count"
    t.integer "page_count"
    t.date "approval_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shoppable_type"
    t.bigint "shoppable_id"
    t.bigint "franchise_statement_id"
    t.integer "samples_quantity", default: 0
    t.index ["franchise_statement_id"], name: "index_shop_cost_sheets_on_franchise_statement_id"
    t.index ["shoppable_type", "shoppable_id"], name: "index_shop_cost_sheets_on_shoppable_type_and_shoppable_id"
  end

  create_table "shop_custom_labels", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "edition_id"
    t.string "uuid"
    t.integer "finishing_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price", precision: 8, scale: 2
    t.bigint "order_id"
    t.index ["edition_id"], name: "index_shop_custom_labels_on_edition_id"
    t.index ["order_id"], name: "index_shop_custom_labels_on_order_id"
    t.index ["uuid"], name: "index_shop_custom_labels_on_uuid"
  end

  create_table "shop_events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uuid"
    t.bigint "order_id"
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "commission_statement_id"
    t.index ["commission_statement_id"], name: "index_shop_events_on_commission_statement_id"
    t.index ["order_id"], name: "index_shop_events_on_order_id"
    t.index ["uuid"], name: "index_shop_events_on_uuid"
  end

  create_table "shop_events_commission_costs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "commission_statement_id"
    t.decimal "cost", precision: 8, scale: 2
    t.decimal "override_cost", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commission_statement_id"], name: "index_shop_events_commission_costs_on_commission_statement_id"
    t.index ["event_id"], name: "index_shop_events_commission_costs_on_event_id"
  end

  create_table "shop_options", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "shoppable_type"
    t.bigint "shoppable_id"
    t.string "name"
    t.string "choice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shoppable_type", "shoppable_id"], name: "index_shop_options_on_shoppable_type_and_shoppable_id"
  end

  create_table "shop_orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uuid"
    t.bigint "sales_rep_id"
    t.bigint "created_by_user_id"
    t.datetime "ordered_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "client_id"
    t.string "source_token"
    t.index ["client_id"], name: "index_shop_orders_on_client_id"
    t.index ["created_by_user_id"], name: "index_shop_orders_on_created_by_user_id"
    t.index ["sales_rep_id"], name: "index_shop_orders_on_sales_rep_id"
    t.index ["uuid"], name: "index_shop_orders_on_uuid"
  end

  create_table "shop_promos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "edition_id"
    t.string "uuid"
    t.integer "finishing_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price", precision: 8, scale: 2
    t.bigint "order_id"
    t.index ["edition_id"], name: "index_shop_promos_on_edition_id"
    t.index ["order_id"], name: "index_shop_promos_on_order_id"
    t.index ["uuid"], name: "index_shop_promos_on_uuid"
  end

  create_table "signature_spots", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_agreement_signature_id"
    t.string "section"
    t.string "ip_address"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid", null: false
    t.index ["order_agreement_signature_id"], name: "index_signature_spots_on_order_agreement_signature_id"
  end

  create_table "sold_page_heading_graphics", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "data_file_size"
    t.integer "width"
    t.integer "height"
    t.integer "ppi"
    t.string "data_content_type"
    t.string "data_file_name"
    t.decimal "height_in_inches", precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "data"
  end

  create_table "sold_page_headings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.text "disclaimer"
    t.decimal "vertical_offset", precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sold_page_listing_uploads", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "sold_page_id", null: false
    t.integer "data_file_size"
    t.string "data_content_type"
    t.string "data_file_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "data"
    t.index ["sold_page_id"], name: "sold_page_listing_uploads_sold_page_id_fkey"
  end

  create_table "sold_page_listings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "sold_page_id", null: false
    t.integer "position", limit: 2, null: false
    t.string "address", null: false
    t.string "neighborhood"
    t.integer "list_price"
    t.date "sold_date"
    t.integer "sale_price"
    t.integer "days_on_market"
    t.integer "beds"
    t.decimal "baths", precision: 4, scale: 2
    t.integer "square_feet"
    t.string "parking"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "custom_value"
    t.index ["sold_page_id"], name: "sold_page_listings_sold_page_id_fkey"
  end

  create_table "sold_pages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "year", null: false
    t.integer "month", limit: 2, null: false
    t.text "provided_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "custom_header"
    t.integer "sold_page_heading_id"
    t.integer "sold_page_heading_graphic_id"
    t.integer "publication_id", null: false
    t.index ["publication_id"], name: "index_sold_pages_on_publication_id"
    t.index ["sold_page_heading_graphic_id"], name: "fk_sold_pages_sold_page_heading_graphic"
    t.index ["sold_page_heading_id"], name: "fk_sold_pages_sold_page_heading"
  end

  create_table "sponsor_index_heading_graphics", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "data_file_size"
    t.integer "width"
    t.integer "height"
    t.string "data_content_type"
    t.string "data_file_name"
    t.decimal "height_in_inches", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "width_in_inches", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "xoffset_in_inches", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "yoffset_in_inches", precision: 8, scale: 2, default: "0.0", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal "border_in_inches", precision: 8, scale: 2, default: "0.0", null: false
    t.string "data"
  end

  create_table "sponsor_indices", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "year", null: false
    t.integer "month", limit: 2
    t.integer "sponsor_index_heading_graphic_id"
    t.text "header_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "directory_id"
    t.integer "publication_id"
    t.index ["directory_id"], name: "index_sponsor_indices_on_directory_id"
    t.index ["publication_id"], name: "index_sponsor_indices_on_publication_id"
    t.index ["sponsor_index_heading_graphic_id"], name: "sponsor_indices_sponsor_index_heading_graphic_id_fkey"
  end

  create_table "sponsor_spotlights", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_item_id", null: false
    t.integer "spotlight_count", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_item_id"], name: "index_sponsor_spotlights_on_order_item_id"
  end

  create_table "sponsorship_users", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "ad_sponsorship_id", null: false
    t.integer "user_id", null: false
    t.index ["ad_sponsorship_id", "user_id"], name: "index_sponsorship_users_on_ad_sponsorship_id_and_user_id", unique: true
  end

  create_table "statement_issues", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "statement_id"
    t.string "statement_type"
    t.boolean "solved", default: false
    t.integer "commission_issue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "record_id"
    t.string "record_type"
    t.integer "resolved_by_id"
    t.datetime "resolved_at"
    t.json "metadata"
    t.index ["commission_issue_id"], name: "index_statement_issues_on_commission_issue_id"
    t.index ["record_type", "record_id"], name: "index_statement_issues_on_record_type_and_record_id"
    t.index ["resolved_by_id"], name: "index_statement_issues_on_resolved_by_id"
    t.index ["statement_type", "statement_id"], name: "index_statement_issues_on_statement_type_and_statement_id"
  end

  create_table "stripe_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "stripeable_type"
    t.bigint "stripeable_id"
    t.string "stripe_id"
    t.string "stripe_klass"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "stripe_object_cache"
    t.datetime "last_cached_at"
    t.integer "cache_counter", default: 0
    t.index ["stripeable_type", "stripeable_id"], name: "index_stripe_records_on_stripeable_type_and_stripeable_id"
  end

  create_table "thumbnails", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "thumbnailable_type"
    t.integer "thumbnailable_id"
    t.string "data"
    t.integer "page"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["thumbnailable_type", "thumbnailable_id"], name: "index_thumbnails_on_thumbnailable_type_and_thumbnailable_id"
  end

  create_table "type_placement_mappings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "ad_type_id"
    t.integer "ad_placement_id"
    t.integer "publication_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["ad_placement_id"], name: "index_type_placement_mappings_on_ad_placement_id"
    t.index ["ad_type_id"], name: "index_type_placement_mappings_on_ad_type_id"
    t.index ["publication_type_id"], name: "index_type_placement_mappings_on_publication_type_id"
  end

  create_table "unapproved_agreement_orders_report_uploads", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "data"
    t.string "data_file_name"
    t.string "data_content_type"
    t.integer "data_file_size"
  end

  create_table "user_assignments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.date "start_on", null: false
    t.date "end_on"
    t.bigint "user_id"
    t.bigint "parent_id", null: false
    t.bigint "user_role_id"
    t.bigint "parent_role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_user_assignments_on_parent_id"
    t.index ["parent_role_id"], name: "index_user_assignments_on_parent_role_id"
    t.index ["user_id"], name: "index_user_assignments_on_user_id"
    t.index ["user_role_id"], name: "index_user_assignments_on_user_role_id"
    t.index ["uuid"], name: "index_user_assignments_on_uuid", unique: true
  end

  create_table "user_businesses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.string "business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_user_businesses_on_business_id"
    t.index ["user_id"], name: "index_user_businesses_on_user_id"
  end

  create_table "user_commission_reports", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "pay_period_id", null: false
    t.date "start_date", null: false
    t.decimal "cash_received_amount", precision: 8, scale: 2
    t.decimal "adc_ae_commission_amount", precision: 8, scale: 2
    t.decimal "newsletter_ad_value", precision: 8, scale: 2
    t.decimal "directory_ad_value", precision: 8, scale: 2
    t.decimal "ad_value_percentage", precision: 5, scale: 3, default: "0.0"
    t.decimal "adjustment_amount", precision: 8, scale: 2
    t.decimal "total", precision: 8, scale: 2
    t.datetime "finalized_at"
    t.date "paid_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "office_id", null: false
    t.decimal "newsletter_publication_cost", precision: 8, scale: 2, default: "0.0"
    t.decimal "directory_publication_cost", precision: 8, scale: 2, default: "0.0"
    t.decimal "ad_management_amount", precision: 8, scale: 2, default: "0.0"
    t.boolean "on_hold", default: false
    t.boolean "received_cost_sheet", default: false
    t.decimal "paid_override_commission_amount", precision: 8, scale: 2
    t.boolean "paid", default: false
    t.decimal "pending_debit_credit_amount", precision: 8, scale: 2
    t.decimal "ad_management_rebate_amount", precision: 8, scale: 2, default: "0.0"
    t.date "end_date"
    t.boolean "reviewed", default: false
    t.index ["office_id"], name: "index_user_commission_reports_on_office_id"
    t.index ["pay_period_id"], name: "index_user_commission_reports_on_pay_period_id"
    t.index ["user_id"], name: "index_user_commission_reports_on_user_id"
  end

  create_table "user_product_lines", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "product_line_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid", limit: 36
    t.index ["product_line_id"], name: "index_user_product_lines_on_product_line_id"
    t.index ["user_id", "product_line_id"], name: "index_user_product_lines_on_user_id_and_product_line_id", unique: true
    t.index ["user_id"], name: "index_user_product_lines_on_user_id"
  end

  create_table "user_roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uuid", limit: 36, null: false
    t.bigint "role_type_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_type_id"], name: "index_user_roles_on_role_type_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
    t.index ["uuid"], name: "index_user_roles_on_uuid", unique: true
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "username"
    t.string "password", limit: 64
    t.string "status", limit: 10, default: "active", null: false
    t.string "time_zone", default: "Eastern Time (US & Canada)", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at"
    t.string "handle", limit: 41
    t.date "birth_date"
    t.string "phone", limit: 15
    t.string "address1", limit: 70
    t.string "city", limit: 50
    t.string "state", limit: 50
    t.string "zip", limit: 20
    t.date "first_publication_date"
    t.integer "first_publication_order_id"
    t.boolean "first_publication_locked", default: false, null: false
    t.integer "ftp_user_id"
    t.boolean "has_current_orders", default: false, null: false
    t.date "promoted_to_ad_on"
    t.string "access_level", default: "unknown"
    t.boolean "w9_received", default: false
    t.boolean "w9_entered_in_qb", default: false
    t.boolean "voided_check_received", default: false
    t.boolean "voided_check_entered_in_ceo", default: false
    t.integer "national_field_trainer_id"
    t.string "address2", limit: 70
    t.string "country", limit: 2, default: "US"
    t.string "uuid", limit: 36
    t.integer "employee_number"
    t.integer "linked_resource_id"
    t.string "linked_resource_type"
    t.integer "entity_id"
    t.index ["entity_id"], name: "index_users_on_entity_id"
    t.index ["linked_resource_type", "linked_resource_id"], name: "index_users_on_linked_resource_type_and_linked_resource_id"
    t.index ["national_field_trainer_id"], name: "index_users_on_national_field_trainer_id"
    t.index ["username"], name: "index_users_on_username"
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

  create_table "webhook_requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "verification_header"
    t.text "data"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "success", default: true
  end

  add_foreign_key "agreement_builder_digital_items", "agreement_builder_digital_items", column: "source_item_id"
  add_foreign_key "agreement_reviews", "users", column: "reviewer_id"
  add_foreign_key "business_contact_tag_eligibilities", "businesses"
  add_foreign_key "business_contact_tag_eligibilities", "contact_tags"
  add_foreign_key "client_rep_assignments", "clients", name: "fk_client_rep_assignments_c"
  add_foreign_key "clients", "agencies"
  add_foreign_key "commission_report_chargebacks", "clients", name: "fk_commission_report_chargebacks_c"
  add_foreign_key "commission_report_chargebacks", "commission_reports", name: "fk_commission_report_chargebacks_cr"
  add_foreign_key "commission_report_details", "commission_report_items", name: "fk_commission_report_details_cri"
  add_foreign_key "commission_report_details", "commission_reports", name: "fk_commission_report_details_cr"
  add_foreign_key "commission_report_directories", "commission_reports", name: "fk_commission_report_directories_cr"
  add_foreign_key "commission_report_directories", "directories", name: "fk_commission_report_directories_d"
  add_foreign_key "commission_report_items", "commission_report_groups", name: "fk_commission_report_items_g"
  add_foreign_key "commission_report_misc_details", "commission_reports", name: "fk_commission_report_misc_details_cr"
  add_foreign_key "commission_report_publication_costs", "commission_reports", name: "fk_commission_report_publication_costs_cr"
  add_foreign_key "commission_reports", "offices", name: "fk_commission_reports_o"
  add_foreign_key "contact_taggings", "contact_tags"
  add_foreign_key "contact_taggings", "contacts"
  add_foreign_key "contacts", "contacts", column: "master_contact_id"
  add_foreign_key "directory_children", "directory_listings", name: "directory_children_directory_listing_id_fkey"
  add_foreign_key "directory_listing_children", "directory_listings", name: "directory_listing_children_directory_listing_id_fkey"
  add_foreign_key "directory_listing_lots", "directories", name: "directory_listing_lots_directory_id_fkey"
  add_foreign_key "directory_listing_uploads", "directories", name: "directory_listing_uploads_directory_id_fkey"
  add_foreign_key "directory_listings", "directories", name: "directory_listings_directory_id_fkey"
  add_foreign_key "effective_order_item_cache", "ad_types"
  add_foreign_key "effective_order_item_cache", "agreement_reviews", column: "last_agreement_review_id"
  add_foreign_key "effective_order_item_cache", "businesses"
  add_foreign_key "effective_order_item_cache", "clients"
  add_foreign_key "effective_order_item_cache", "o2_order_items", column: "order_item_id"
  add_foreign_key "effective_order_item_cache", "o2_orders", column: "order_id"
  add_foreign_key "effective_order_item_cache", "offices"
  add_foreign_key "effective_order_item_cache", "publications"
  add_foreign_key "email_logs", "users", name: "fk_email_logs_users"
  add_foreign_key "invoice_fields", "o2_invoices", column: "invoice_id", name: "fk_invoice_fields_o2_invoices"
  add_foreign_key "invoice_fields", "o2_orders", column: "order_id", name: "fk_invoice_fields_o2_orders"
  add_foreign_key "job_report_subscriptions", "users"
  add_foreign_key "late_fee_credits", "commission_report_details", name: "fk_late_fee_credits_commission_report_detail"
  add_foreign_key "late_fee_credits", "users", name: "fk_late_fee_credits_user"
  add_foreign_key "notes", "users", name: "fk_notes_user"
  add_foreign_key "o2_ad_publications", "editions"
  add_foreign_key "o2_ad_schedules", "o2_orders", column: "order_id", name: "fk_o2_ad_schedules_o2_orders"
  add_foreign_key "o2_ad_schedules", "users", column: "confirmed_by", name: "fk_o2_ad_schedules_users"
  add_foreign_key "o2_invoice_item_receipt_refunds", "o2_invoice_item_receipts", column: "invoice_item_receipt_id", name: "fk_o2_invoice_item_receipt_refunds_o2_invoice_item_receipts"
  add_foreign_key "o2_invoice_item_receipt_refunds", "o2_refunds", column: "refund_id", name: "fk_o2_invoice_item_receipt_refunds_o2_refunds"
  add_foreign_key "o2_invoices", "clients", name: "fk_o2_invoices_clients"
  add_foreign_key "o2_order_items", "ad_placements", name: "fk_o2_order_items_ad_placements"
  add_foreign_key "o2_order_items", "ad_sponsorships", name: "fk_o2_order_items_ad_sponsorships"
  add_foreign_key "o2_order_items", "ad_types", name: "fk_o2_order_items_ad_types"
  add_foreign_key "o2_order_items", "advisory_board_categories"
  add_foreign_key "o2_order_items", "index_categories", name: "fk_o2_order_items_index_category_id"
  add_foreign_key "o2_order_items", "o2_order_items", column: "adjusted_item_id", name: "fk_o2_order_items_adjusted_item_id"
  add_foreign_key "o2_order_items", "o2_order_items", column: "parent_item_id", name: "fk_o2_order_items_parent_item_id"
  add_foreign_key "o2_order_items", "o2_orders", column: "order_id", name: "fk_o2_order_items_o2_orders"
  add_foreign_key "o2_orders", "clients", name: "fk_o2_orders_clients"
  add_foreign_key "o2_orders", "users", column: "created_by_user_id", name: "fk_o2_orders_created_by_user"
  add_foreign_key "o2_orders", "users", column: "sales_rep_id", name: "fk_o2_orders_users"
  add_foreign_key "o2_receipts", "check_batches", name: "fk_o2_receipts_check_batch_id"
  add_foreign_key "o2_receipts", "clients", name: "fk_o2_receipts_clients"
  add_foreign_key "o2_receipts", "o2_orders", column: "tradeout_order_id", name: "fk_o2_receipts_tradeout_order_id"
  add_foreign_key "o2_receipts", "o2_transactions", column: "transaction_id", name: "fk_o2_receipts_o2_transactions"
  add_foreign_key "o2_refunds", "clients", name: "fk_o2_refunds_clients"
  add_foreign_key "o2_refunds", "o2_disputes", column: "dispute_id", name: "fk_o2_refunds_o2_disputes"
  add_foreign_key "o2_transactions", "o2_refunds", column: "refund_id", name: "fk_o2_transactions_o2_refunds"
  add_foreign_key "pay_periods", "users", name: "fk_pay_periods_users"
  add_foreign_key "publication_freights", "publication_types"
  add_foreign_key "qualifying_sales", "clients"
  add_foreign_key "recurring_subscriptions", "services"
  add_foreign_key "resident_business_headings", "resident_business_heading_graphics", column: "resident_business_hg_id", name: "resident_business_headings_resident_business_hg_id_fkey"
  add_foreign_key "resident_business_listing_uploads", "resident_businesses", name: "resident_business_listing_uploads_resident_business_id_fkey"
  add_foreign_key "roles", "offices", name: "fk_roles_o"
  add_foreign_key "roles", "users", name: "fk_roles_u"
  add_foreign_key "sold_page_listing_uploads", "sold_pages", name: "sold_page_listing_uploads_sold_page_id_fkey"
  add_foreign_key "sold_page_listings", "sold_pages", name: "sold_page_listings_sold_page_id_fkey"
  add_foreign_key "sold_pages", "sold_page_heading_graphics", name: "fk_sold_pages_sold_page_heading_graphic"
  add_foreign_key "sold_pages", "sold_page_headings", name: "fk_sold_pages_sold_page_heading"
  add_foreign_key "sponsor_indices", "sponsor_index_heading_graphics", name: "sponsor_indices_sponsor_index_heading_graphic_id_fkey"
  add_foreign_key "users", "entities"
end
