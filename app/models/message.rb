class Message < ActiveRecord::Base
	belongs_to :user, inverse_of: :messages
	belongs_to :reciever, class_name: "User", inverse_of: :messages
	validates :content, presence: true, length: { maximum: 500, minimum: 2 }
	validates :reciever_id, presence: true
end
