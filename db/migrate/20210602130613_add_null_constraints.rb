class AddNullConstraints < ActiveRecord::Migration[6.1]
  def change
    change_column_null :conversations, :user_id1, false
    change_column_null :conversations, :user_id2, false
    change_column_null :conversations, :topic_id, false

    change_column_null :messages, :conversation_id, false
    change_column_null :messages, :user_id, false
    change_column_null :messages, :message, false
  end
end
