# class AddConfirmableFields < ActiveRecord::Migration[6.1]
#   change_table :users, bulk: true do |t|
#     t.string   :confirmation_token
#     t.datetime :confirmed_at
#     t.datetime :confirmation_sent_at
#     t.string   :unconfirmed_email
#   end

#   add_index :users, :confirmation_token, unique: true
# end
