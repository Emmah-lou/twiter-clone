class CreateTweetTable < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.string :message
      t.timestamps
    end
  end
end
