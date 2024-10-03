class RenameTypeInSessions < ActiveRecord::Migration[7.2]
  def change
    rename_column :sessions, :type, :session_type
  end
end
