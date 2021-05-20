class CreateMessage < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :conversation_id
      t.integer :user_id
      t.string :message
      t.timestamps
      t.index ['user_id'], name: 'index_messages_on_user_id'
      t.index ['conversation_id'], name: 'index_messages_on_conversation_id'
    end
  end
end
