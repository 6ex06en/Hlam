class Option < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :email_notice, inclusion: { in: [true, false] }
  validates :email_notice, exclusion: { in: [nil] }
end
