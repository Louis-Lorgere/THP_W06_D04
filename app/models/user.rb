class User < ApplicationRecord
  validates :name, length: { minimum: 5 }, uniqueness: true
  validates :password, length: { in: 6..20 }
  belongs_to :city
  has_many :gossips
  has_many :sent_messages, foreign_key: 'sender_id', class_name: "PrivateMessage"
  has_many :private_message_recipient_joins
  has_many :received_messages, foreign_key: 'recipient_id', class_name: "private_message_recipient_join"
  has_secure_password
  has_many :likes
end
