class ChangeLatLonName < ActiveRecord::Migration[6.1]
  change_table :targets, bulk: true do |t|
    t.remove :lat
    t.remove :lon
    t.decimal :latitude
    t.decimal :longitude
  end
end
