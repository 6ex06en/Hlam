class User < ActiveRecord::Base
has_many :microposts, dependent: :destroy
has_many :relationships, foreign_key: "follower_id", dependent: :destroy
has_many :followed_users, through: :relationships, source: :followed
has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
has_many :followers, through: :reverse_relationships, source: :follower
has_many :messages, inverse_of: :user, dependent: :destroy
has_many :recieve_messages, foreign_key: "reciever_id", class_name: "Message"
has_many :recieve_messages_unread, -> { where :read => false }, foreign_key: "reciever_id", 
            class_name: "Message", inverse_of: :user
has_one :option, dependent: :destroy
before_create :create_remember_token
before_save { self.email = email.downcase }
validates :name,  presence: true, length: { maximum: 50 }
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
						uniqueness: { case_sensitive: false }
has_secure_password
validates :password, length: { minimum: 6 }

def User.new_remember_token
    SecureRandom.urlsafe_base64
end

def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
end

def feed
    Micropost.from_users_followed_by(self)
end

def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
end

def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
end

def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
end

def send_private(other_user, cont)
    messages.create!(reciever_id: other_user.id, content: cont)
end


def all_reply
    Micropost.replies(self)
end

def only_mic
  Micropost.microposts_without_reply(self)            
end

private

def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
end
end
