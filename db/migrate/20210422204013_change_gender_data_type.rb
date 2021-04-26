class ChangeGenderDataType < ActiveRecord::Migration[6.1]
  def up
    remove_column :users, :gender
    add_column :users, :gender, :integer
  end
end
