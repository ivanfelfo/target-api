class CreateTargets < ActiveRecord::Migration[6.1]
  def change
    create_table :targets do |t|
      t.integer :topic_id
      t.integer :user_id
      t.string :title
      t.decimal :radius
      t.decimal :lon
      t.decimal :lat
      t.timestamps
      t.index ['topic_id'], name: 'index_targets_on_topic_id'
      t.index ['user_id'], name: 'index_targets_on_user_id'
    end
  end
end
