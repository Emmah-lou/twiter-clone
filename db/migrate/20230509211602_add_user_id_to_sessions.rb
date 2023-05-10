class AddUserIdToSessions < ActiveRecord::Migration[6.1]
  def change
    add_belongs_to :sessions, :user, null: false, foreign_key: true
  end
end
