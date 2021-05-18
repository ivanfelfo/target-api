class ChangeTargetFieldsToNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :targets, :title, false
    change_column_null :targets, :user_id, false
    change_column_null :targets, :topic_id, false
  end
end
