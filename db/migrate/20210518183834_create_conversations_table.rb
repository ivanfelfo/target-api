class CreateConversationsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.integer :user_id1
      t.integer :user_id2
      t.integer :topic_id
      t.boolean :read, default: false
      t.timestamps
      t.index ['topic_id'], name: 'index_conversations_on_topic_id'
      t.index ['user_id1'], name: 'index_conversations_on_user_id1'
      t.index ['user_id2'], name: 'index_conversations_on_user_id2'
    end

    add_index(:conversations, %i[user_id1 user_id2], unique: true)
  end
end
