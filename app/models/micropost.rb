class Micropost < ActiveRecord::Base
belongs_to :user
has_many :includ_replies, foreign_key: "including_replies", 
						  class_name: "Micropost", dependent: :destroy 
default_scope -> { order('created_at DESC') }
validates :user_id, presence: true
validates :content, presence: true, length: { maximum: 140 }

def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id AND including_replies IS NULL",
           user_id: user.id)
end

def self.replies(user)
	where("in_reply_to = :user_id", user_id: user.id)
end

def self.microposts_without_reply(user)
    where("in_reply_to IS NULL AND user_id = :user_id", user_id: user.id)  
end

end

# where(in_reply_to: micro.id )
#user = u.id
#where("SELECT in_reply_to FROM microposts WHERE in_reply_to = #{user}")