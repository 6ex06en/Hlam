class AddIndexToMessagesRecieverId < ActiveRecord::Migration
  def change
  	add_index :messages, :reciever_id
  	add_index :messages, :user_id
  end
end
