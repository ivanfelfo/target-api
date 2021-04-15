class AddGenderColumn < ActiveRecord::Migration[6.1]
  def up
    add_column(:users, :gender, :boolean)
  end

  def down
    remove_column(:users, :gender)
  end
end
