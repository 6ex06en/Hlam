class AddInReplyToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :in_reply_to, :string
    add_column :microposts, :including_replies, :string
  end
end
