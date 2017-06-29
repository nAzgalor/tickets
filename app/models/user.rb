class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :authors, class_name: 'Conversation', foreign_key: 'author_id'
  has_many :receivers, class_name: 'Conversation', foreign_key: 'receiver_id'
  has_many :personal_messages, dependent: :destroy

  def self.available_to_message(current_user_id)
    where(blocked: false).where.not(id: current_user_id)
  end
end
