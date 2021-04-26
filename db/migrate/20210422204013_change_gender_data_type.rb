class ChangeGenderDataType < ActiveRecord::Migration[6.1]
  change_table :users, bulk: true do |t|
    t.remove :gender
    t.integer :gender, default: 3 # 3 = unknown
  end
end
