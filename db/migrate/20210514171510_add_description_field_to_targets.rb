class AddDescriptionFieldToTargets < ActiveRecord::Migration[6.1]
  def change
    change_table :targets, bulk: true do |t|
      t.string :description
    end
  end
end
