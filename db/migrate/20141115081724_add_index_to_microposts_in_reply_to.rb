class AddIndexToMicropostsInReplyTo < ActiveRecord::Migration
  def change
  end
  add_index :microposts, :in_reply_to
end
