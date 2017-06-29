class Conversation < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_many :personal_messages, -> { order(created_at: :asc) }, dependent: :destroy

  validates :author, uniqueness: { scope: :receiver }

  def self.participating(user)
    where("(conversations.author_id = ? OR conversations.receiver_id = ?)", user.id, user.id)
  end

  def self.between(sender_id, receiver_id)
    where(author_id: sender_id, receiver_id: receiver_id).or(where(author_id: receiver_id, receiver_id: sender_id)).limit(1)
  end

  def with(current_user)
    author == current_user ? receiver : author
  end

  def participates?(current_user)
    author == current_user || receiver == current_user
  end
end
